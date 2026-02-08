type LFUCache struct {
    capacity int
    minFreq  int
    keyFreq  map[int]int
    freqList map[int]*list.List
    keyNode  map[int]*list.Element
}

type Node struct {
    key, value int
}

func Constructor(capacity int) LFUCache {
    return LFUCache{
        capacity: capacity,
        keyFreq:  make(map[int]int),
        freqList: make(map[int]*list.List),
        keyNode:  make(map[int]*list.Element),
    }
}

func (this *LFUCache) Get(key int) int {
    if this.capacity == 0 {
        return -1
    }
    freq, exists := this.keyFreq[key]
    if !exists {
        return -1
    }
    this.update(key, freq)
    return this.keyNode[key].Value.(*Node).value
}

func (this *LFUCache) Put(key int, value int) {
    if this.capacity == 0 {
        return
    }
    if freq, exists := this.keyFreq[key]; exists {
        this.keyNode[key].Value.(*Node).value = value
        this.update(key, freq)
    } else {
        if len(this.keyFreq) >= this.capacity {
            this.evict()
        }
        this.keyFreq[key] = 1
        this.minFreq = 1
        if this.freqList[1] == nil {
            this.freqList[1] = list.New()
        }
        this.keyNode[key] = this.freqList[1].PushFront(&Node{key, value})
    }
}

func (this *LFUCache) update(key int, freq int) {
    this.keyFreq[key]++
    oldList := this.freqList[freq]
    oldList.Remove(this.keyNode[key])
    if oldList.Len() == 0 {
        delete(this.freqList, freq)
        if freq == this.minFreq {
            this.minFreq++
        }
    }
    if this.freqList[freq+1] == nil {
        this.freqList[freq+1] = list.New()
    }
    this.keyNode[key] = this.freqList[freq+1].PushFront(&Node{key, this.keyNode[key].Value.(*Node).value})
}

func (this *LFUCache) evict() {
    oldList := this.freqList[this.minFreq]
    evictNode := oldList.Back()
    oldList.Remove(evictNode)
    if oldList.Len() == 0 {
        delete(this.freqList, this.minFreq)
    }
    delete(this.keyFreq, evictNode.Value.(*Node).key)
    delete(this.keyNode, evictNode.Value.(*Node).key)
}