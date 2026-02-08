package main

type LFUCache struct {
    capacity int
    cache    map[int]*Node
    freqMap  map[int]*List
    minFreq  int
    size     int
}

type Node struct {
    key, value int
    freq       int
    next, prev *Node
}

type List struct {
    head, tail *Node
    size       int
}

func Constructor(capacity int) LFUCache {
    return LFUCache{
        capacity: capacity,
        cache:    make(map[int]*Node),
        freqMap:  make(map[int]*List),
        minFreq:  1,
        size:     0,
    }
}

func (this *LFUCache) Get(key int) int {
    node, ok := this.cache[key]
    if !ok {
        return -1
    }
    this.increaseFreq(node)
    return node.value
}

func (this *LFUCache) Put(key int, value int) {
    if this.capacity == 0 {
        return
    }
    if node, ok := this.cache[key]; ok {
        node.value = value
        this.increaseFreq(node)
        return
    }
    if this.size >= this.capacity {
        this.removeMinFreqNode()
    }
    newNode := &Node{
        key:   key,
        value: value,
        freq:  1,
    }
    this.cache[key] = newNode
    this.size++
    this.addFreqNode(newNode, 1)
}

func (this *LFUCache) increaseFreq(node *Node) {
    oldFreq := node.freq
    this.removeNodeFromList(node, oldFreq)
    node.freq++
    this.addFreqNode(node, node.freq)
    if this.freqMap[oldFreq].size == 0 {
        delete(this.freqMap, oldFreq)
        if oldFreq == this.minFreq {
            this.minFreq++
        }
    }
}

func (this *LFUCache) removeMinFreqNode() {
    list, ok := this.freqMap[this.minFreq]
    if !ok {
        return
    }
    node := list.tail
    this.removeNodeFromList(node, this.minFreq)
    delete(this.cache, node.key)
    this.size--
}

func (this *LFUCache) addFreqNode(node *Node, freq int) {
    if _, ok := this.freqMap[freq]; !ok {
        this.freqMap[freq] = &List{head: &Node{}, tail: &Node{}}
        this.freqMap[freq].head.next = this.freqMap[freq].tail
        this.freqMap[freq].tail.prev = this.freqMap[freq].head
    }
    list := this.freqMap[freq]
    node.next = list.head.next
    node.prev = list.head
    list.head.next.prev = node
    list.head.next = node
    list.size++
}

func (this *LFUCache) removeNodeFromList(node *Node, freq int) {
    list := this.freqMap[freq]
    node.prev.next = node.next
    node.next.prev = node.prev
    list.size--
}