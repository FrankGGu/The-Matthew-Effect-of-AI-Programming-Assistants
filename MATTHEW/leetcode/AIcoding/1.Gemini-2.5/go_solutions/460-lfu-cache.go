package main

import (
	"container/list"
)

type Node struct {
	key     int
	value   int
	freq    int
	element *list.Element // Pointer to the list.Element containing this Node
}

type LFUCache struct {
	capacity   int
	size       int
	minFreq    int
	keyToNode  map[int]*Node
	freqToList map[int]*list.List // map from frequency to a doubly linked list of Nodes
}

func Constructor(capacity int) LFUCache {
	return LFUCache{
		capacity:   capacity,
		size:       0,
		minFreq:    0,
		keyToNode:  make(map[int]*Node),
		freqToList: make(map[int]*list.List),
	}
}

func (lfu *LFUCache) increaseFreq(node *Node) {
	// Remove node from its current frequency list
	oldFreq := node.freq
	lfu.freqToList[oldFreq].Remove(node.element)

	// If the old frequency list is now empty and it was the minFreq list,
	// then minFreq must increase.
	if lfu.freqToList[oldFreq].Len() == 0 {
		delete(lfu.freqToList, oldFreq) // Clean up empty list
		if oldFreq == lfu.minFreq {
			lfu.minFreq++
		}
	}

	// Increment node's frequency
	node.freq++
	newFreq := node.freq

	// Get or create the new frequency list
	if _, ok := lfu.freqToList[newFreq]; !ok {
		lfu.freqToList[newFreq] = list.New()
	}

	// Add node to the front of the new frequency list (most recently used for this freq)
	node.element = lfu.freqToList[newFreq].PushFront(node)
}

func (lfu *LFUCache) Get(key int) int {
	if lfu.capacity == 0 {
		return -1
	}

	if node, ok := lfu.keyToNode[key]; ok {
		lfu.increaseFreq(node)
		return node.value
	}
	return -1
}

func (lfu *LFUCache) Put(key int, value int) {
	if lfu.capacity == 0 {
		return
	}

	if node, ok := lfu.keyToNode[key]; ok {
		// Key already exists, update value and frequency
		node.value = value
		lfu.increaseFreq(node)
	} else {
		// Key does not exist
		if lfu.size == lfu.capacity {
			// Cache is full, evict LFU item
			// The LFU item is the last element in the list associated with minFreq
			minFreqList := lfu.freqToList[lfu.minFreq]

			// Get the least recently used node from the minFreq list
			evictedElement := minFreqList.Back()
			evictedNode := evictedElement.Value.(*Node)

			// Remove from keyToNode map
			delete(lfu.keyToNode, evictedNode.key)

			// Remove from the list
			minFreqList.Remove(evictedElement)

			// If the minFreq list becomes empty, delete it from freqToList map
			if minFreqList.Len() == 0 {
				delete(lfu.freqToList, lfu.minFreq)
			}
			lfu.size--
		}

		// Add new node
		newNode := &Node{
			key:   key,
			value: value,
			freq:  1,
		}

		// Add to keyToNode map
		lfu.keyToNode[key] = newNode

		// Get or create the list for frequency 1
		if _, ok := lfu.freqToList[1]; !ok {
			lfu.freqToList[1] = list.New()
		}

		// Add new node to the front of the freq 1 list
		newNode.element = lfu.freqToList[1].PushFront(newNode)

		// Update minFreq to 1, as a new item with freq 1 is added
		lfu.minFreq = 1
		lfu.size++
	}
}