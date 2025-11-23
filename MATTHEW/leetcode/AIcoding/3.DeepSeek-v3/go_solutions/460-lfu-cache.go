type LFUCache struct {
    capacity int
    minFreq  int
    keyToNode map[int]*Node
    freqToList map[int]*List
}

type Node struct {
    key, val, freq int
    prev, next     *Node
}

type List struct {
    head, tail *Node
    size       int
}

func newList() *List {
    head, tail := &Node{}, &Node{}
    head.next = tail
    tail.prev = head
    return &List{head, tail, 0}
}

func (l *List) removeNode(node *Node) {
    node.prev.next = node.next
    node.next.prev = node.prev
    l.size--
}

func (l *List) addToFront(node *Node) {
    node.next = l.head.next
    node.prev = l.head
    l.head.next.prev = node
    l.head.next = node
    l.size++
}

func Constructor(capacity int) LFUCache {
    return LFUCache{
        capacity:   capacity,
        keyToNode:  make(map[int]*Node),
        freqToList: make(map[int]*List),
    }
}

func (this *LFUCache) Get(key int) int {
    if node, ok := this.keyToNode[key]; ok {
        this.updateFrequency(node)
        return node.val
    }
    return -1
}

func (this *LFUCache) Put(key int, value int) {
    if this.capacity == 0 {
        return
    }
    if node, ok := this.keyToNode[key]; ok {
        node.val = value
        this.updateFrequency(node)
        return
    }
    if len(this.keyToNode) == this.capacity {
        list := this.freqToList[this.minFreq]
        delete(this.keyToNode, list.tail.prev.key)
        list.removeNode(list.tail.prev)
        if list.size == 0 {
            delete(this.freqToList, this.minFreq)
        }
    }
    newNode := &Node{key: key, val: value, freq: 1}
    this.keyToNode[key] = newNode
    if _, ok := this.freqToList[1]; !ok {
        this.freqToList[1] = newList()
    }
    this.freqToList[1].addToFront(newNode)
    this.minFreq = 1
}

func (this *LFUCache) updateFrequency(node *Node) {
    freq := node.freq
    list := this.freqToList[freq]
    list.removeNode(node)
    if list.size == 0 {
        delete(this.freqToList, freq)
        if freq == this.minFreq {
            this.minFreq++
        }
    }
    node.freq++
    if _, ok := this.freqToList[node.freq]; !ok {
        this.freqToList[node.freq] = newList()
    }
    this.freqToList[node.freq].addToFront(node)
}