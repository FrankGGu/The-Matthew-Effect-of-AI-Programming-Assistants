type Node struct {
    key, value int
    prev, next *Node
}

type LRUCache struct {
    capacity int
    cache    map[int]*Node
    head     *Node
    tail     *Node
}

func Constructor(capacity int) LRUCache {
    head := &Node{}
    tail := &Node{}
    head.next = tail
    tail.prev = head
    return LRUCache{
        capacity: capacity,
        cache:    make(map[int]*Node),
        head:     head,
        tail:     tail,
    }
}

func (this *LRUCache) Get(key int) int {
    if node, exists := this.cache[key]; exists {
        this.moveToHead(node)
        return node.value
    }
    return -1
}

func (this *LRUCache) Put(key int, value int) {
    if node, exists := this.cache[key]; exists {
        node.value = value
        this.moveToHead(node)
    } else {
        newNode := &Node{key: key, value: value}
        this.cache[key] = newNode
        this.addNode(newNode)
        if len(this.cache) > this.capacity {
            tail := this.removeTail()
            delete(this.cache, tail.key)
        }
    }
}

func (this *LRUCache) addNode(node *Node) {
    node.prev = this.head
    node.next = this.head.next
    this.head.next.prev = node
    this.head.next = node
}

func (this *LRUCache) removeNode(node *Node) {
    prevNode := node.prev
    nextNode := node.next
    prevNode.next = nextNode
    nextNode.prev = prevNode
}

func (this *LRUCache) moveToHead(node *Node) {
    this.removeNode(node)
    this.addNode(node)
}

func (this *LRUCache) removeTail() *Node {
    tailNode := this.tail.prev
    this.removeNode(tailNode)
    return tailNode
}