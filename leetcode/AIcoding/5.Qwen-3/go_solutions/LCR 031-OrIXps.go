package main

type LRUCache struct {
    capacity int
    cache    map[int]*DLinkedNode
    head     *DLinkedNode
    tail     *DLinkedNode
}

type DLinkedNode struct {
    key, value int
    prev       *DLinkedNode
    next       *DLinkedNode
}

func Constructor(capacity int) LRUCache {
    lru := LRUCache{
        capacity: capacity,
        cache:    make(map[int]*DLinkedNode),
        head:     &DLinkedNode{},
        tail:     &DLinkedNode{},
    }
    lru.head.next = lru.tail
    lru.tail.prev = lru.head
    return lru
}

func (this *LRUCache) Get(key int) int {
    if node, ok := this.cache[key]; ok {
        this.moveToHead(node)
        return node.value
    }
    return -1
}

func (this *LRUCache) Put(key int, value int) {
    if node, ok := this.cache[key]; ok {
        node.value = value
        this.moveToHead(node)
    } else {
        newNode := &DLinkedNode{
            key:   key,
            value: value,
        }
        this.cache[key] = newNode
        this.addToHead(newNode)
        if len(this.cache) > this.capacity {
            removed := this.removeTail()
            delete(this.cache, removed.key)
        }
    }
}

func (this *LRUCache) moveToHead(node *DLinkedNode) {
    this.removeNode(node)
    this.addToHead(node)
}

func (this *LRUCache) removeNode(node *DLinkedNode) {
    node.prev.next = node.next
    node.next.prev = node.prev
}

func (this *LRUCache) addToHead(node *DLinkedNode) {
    node.next = this.head.next
    node.prev = this.head
    this.head.next.prev = node
    this.head.next = node
}

func (this *LRUCache) removeTail() *DLinkedNode {
    node := this.tail.prev
    this.removeNode(node)
    return node
}