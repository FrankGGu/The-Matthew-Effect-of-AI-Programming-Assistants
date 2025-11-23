type LRUCache struct {
	capacity int
	cache    map[int]*node
	head     *node
	tail     *node
}

type node struct {
	key   int
	value int
	prev  *node
	next  *node
}

func Constructor(capacity int) LRUCache {
	l := LRUCache{
		capacity: capacity,
		cache:    make(map[int]*node),
		head:     &node{},
		tail:     &node{},
	}
	l.head.next = l.tail
	l.tail.prev = l.head
	return l
}

func (this *LRUCache) Get(key int) int {
	if n, ok := this.cache[key]; ok {
		this.moveToHead(n)
		return n.value
	}
	return -1
}

func (this *LRUCache) Put(key int, value int) {
	if n, ok := this.cache[key]; ok {
		n.value = value
		this.moveToHead(n)
		return
	}

	newNode := &node{key: key, value: value}
	this.cache[key] = newNode
	this.addToHead(newNode)

	if len(this.cache) > this.capacity {
		tail := this.removeTail()
		delete(this.cache, tail.key)
	}
}

func (this *LRUCache) addToHead(node *node) {
	node.prev = this.head
	node.next = this.head.next
	this.head.next.prev = node
	this.head.next = node
}

func (this *LRUCache) removeNode(node *node) {
	node.prev.next = node.next
	node.next.prev = node.prev
}

func (this *LRUCache) moveToHead(node *node) {
	this.removeNode(node)
	this.addToHead(node)
}

func (this *LRUCache) removeTail() *node {
	tail := this.tail.prev
	this.removeNode(tail)
	return tail
}