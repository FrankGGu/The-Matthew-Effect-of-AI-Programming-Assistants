type LFUCache struct {
    capacity int
    cache    map[int]*node
    freqMap  map[int]*list
    minFreq  int
}

type node struct {
    key   int
    value int
    freq  int
}

type list struct {
    head *node
    tail *node
}

func (l *list) add(n *node) {
    if l.head == nil {
        l.head = n
        l.tail = n
    } else {
        n.tail = l.tail
        l.tail.head = n
        l.tail = n
    }
}

func (l *list) remove(n *node) {
    if n.head == nil && n.tail == nil {
        l.head = nil
        l.tail = nil
    } else if n.head == nil {
        l.head = n.tail
        n.tail.head = nil
    } else if n.tail == nil {
        l.tail = n.head
        n.head.tail = nil
    } else {
        n.head.tail = n.tail
        n.tail.head = n.head
    }
}

func Constructor(capacity int) LFUCache {
    return LFUCache{
        capacity: capacity,
        cache:    make(map[int]*node),
        freqMap:  make(map[int]*list),
        minFreq:  0,
    }
}

func (this *LFUCache) Get(key int) int {
    if this.capacity == 0 {
        return -1
    }
    n, ok := this.cache[key]
    if !ok {
        return -1
    }
    this.updateFreq(n)
    return n.value
}

func (this *LFUCache) Put(key int, value int) {
    if this.capacity == 0 {
        return
    }
    n, ok := this.cache[key]
    if ok {
        n.value = value
        this.updateFreq(n)
        return
    }

    if len(this.cache) == this.capacity {
        l := this.freqMap[this.minFreq]
        oldest := l.head
        delete(this.cache, oldest.key)
        l.remove(oldest)
        if l.head == nil {
            delete(this.freqMap, this.minFreq)
        }
    }

    newNode := &node{key: key, value: value, freq: 1}
    this.cache[key] = newNode
    l, ok := this.freqMap[1]
    if !ok {
        l = &list{}
        this.freqMap[1] = l
    }
    l.add(newNode)
    this.minFreq = 1
}

func (this *LFUCache) updateFreq(n *node) {
    oldFreq := n.freq
    oldList := this.freqMap[oldFreq]
    oldList.remove(n)
    if oldList.head == nil {
        delete(this.freqMap, oldFreq)
        if this.minFreq == oldFreq {
            this.minFreq++
        }
    }

    n.freq++
    newFreq := n.freq
    newList, ok := this.freqMap[newFreq]
    if !ok {
        newList = &list{}
        this.freqMap[newFreq] = newList
    }
    newList.add(n)
}