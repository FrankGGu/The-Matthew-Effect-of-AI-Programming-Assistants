package main

type listNode struct {
	val  int
	keys map[string]struct{} // Using map[string]struct{} as a set for O(1) key lookup/deletion
	prev *listNode
	next *listNode
}

type AllOne struct {
	head       *listNode // Sentinel head
	tail       *listNode // Sentinel tail
	keyCounts  map[string]int      // key -> count
	countNodes map[int]*listNode // count -> listNode
}

func Constructor() AllOne {
	head := &listNode{val: 0} // Sentinel
	tail := &listNode{val: 0} // Sentinel
	head.next = tail
	tail.prev = head
	return AllOne{
		head:       head,
		tail:       tail,
		keyCounts:  make(map[string]int),
		countNodes: make(map[int]*listNode),
	}
}

func (this *AllOne) addAfter(node, newNode *listNode) {
	newNode.prev = node
	newNode.next = node.next
	node.next.prev = newNode
	node.next = newNode
}

func (this *AllOne) removeNode(node *listNode) {
	node.prev.next = node.next
	node.next.prev = node.prev
	node.prev = nil // For GC
	node.next = nil // For GC
}

func (this *AllOne) Inc(key string) {
	count, exists := this.keyCounts[key]

	if !exists {
		// New key, count becomes 1
		this.keyCounts[key] = 1

		// Check if node for count 1 exists
		nodeFor1, nodeExists := this.countNodes[1]
		if !nodeExists {
			// Create new node for count 1 and insert after head (the first node in the list)
			nodeFor1 = &listNode{val: 1, keys: make(map[string]struct{})}
			this.addAfter(this.head, nodeFor1)
			this.countNodes[1] = nodeFor1
		}
		nodeFor1.keys[key] = struct{}{}
	} else {
		// Key exists, increment count from `count` to `count+1`
		currNode := this.countNodes[count]
		delete(currNode.keys, key) // Remove key from current count's node

		// Determine the insertion point for the new node (or existing node) for count+1
		// If currNode becomes empty, it will be removed, and the new node for count+1 should
		// be inserted after currNode's predecessor. Otherwise, it's inserted after currNode.
		insertPoint := currNode
		if len(currNode.keys) == 0 {
			this.removeNode(currNode)
			delete(this.countNodes, count)
			insertPoint = currNode.prev // currNode.prev is now the node before where currNode was
		}

		this.keyCounts[key] = count + 1
		nextNodeForCountPlus1, nextNodeExists := this.countNodes[count+1]
		if !nextNodeExists {
			// Create new node for count+1
			nextNodeForCountPlus1 = &listNode{val: count + 1, keys: make(map[string]struct{})}
			this.addAfter(insertPoint, nextNodeForCountPlus1)
			this.countNodes[count+1] = nextNodeForCountPlus1
		}
		nextNodeForCountPlus1.keys[key] = struct{}{}
	}
}

func (this *AllOne) Dec(key string) {
	count, exists := this.keyCounts[key]

	if !exists {
		// Key does not exist, do nothing
		return
	}

	// Key exists, decrement count from `count` to `count-1`
	currNode := this.countNodes[count]
	delete(currNode.keys, key) // Remove key from current count's node

	// The node for count-1 (if it exists or is created) should be inserted before currNode.
	// The insertion point for `addAfter` is `currNode.prev`.
	insertPoint := currNode.prev 

	if len(currNode.keys) == 0 {
		this.removeNode(currNode)
		delete(this.countNodes, count)
	}

	if count == 1 {
		// Count becomes 0, remove key entirely
		delete(this.keyCounts, key)
	} else {
		// Count becomes `count-1`
		this.keyCounts[key] = count - 1
		prevNodeForCountMinus1, prevNodeExists := this.countNodes[count-1]
		if !prevNodeExists {
			// Create new node for count-1
			prevNodeForCountMinus1 = &listNode{val: count - 1, keys: make(map[string]struct{})}
			this.addAfter(insertPoint, prevNodeForCountMinus1) // Insert before currNode
			this.countNodes[count-1] = prevNodeForCountMinus1
		}
		prevNodeForCountMinus1.keys[key] = struct{}{}
	}
}

func (this *AllOne) GetMaxKey() string {
	if this.head.next == this.tail {
		return "" // List is empty
	}
	// The node before tail has the maximum count
	maxNode := this.tail.prev
	for key := range maxNode.keys {
		return key // Return any key
	}
	return "" // Should not be reached if list is not empty and maxNode.keys is not empty
}

func (this *AllOne) GetMinKey() string {
	if this.head.next == this.tail {
		return "" // List is empty
	}
	// The node after head has the minimum count
	minNode := this.head.next
	for key := range minNode.keys {
		return key // Return any key
	}
	return "" // Should not be reached if list is not empty and minNode.keys is not empty
}