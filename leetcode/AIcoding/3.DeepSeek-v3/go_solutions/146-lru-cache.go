type LRUCache struct {
    capacity int
    cache    map[int]*list.Element
    list     *list.List
}

type pair struct {
    key   int
    value int
}

func Constructor(capacity int) LRUCache {
    return LRUCache{
        capacity: capacity,
        cache:    make(map[int]*list.Element),
        list:     list.New(),
    }
}

func (this *LRUCache) Get(key int) int {
    if elem, ok := this.cache[key]; ok {
        this.list.MoveToFront(elem)
        return elem.Value.(*pair).value
    }
    return -1
}

func (this *LRUCache) Put(key int, value int) {
    if elem, ok := this.cache[key]; ok {
        elem.Value.(*pair).value = value
        this.list.MoveToFront(elem)
        return
    }

    if this.list.Len() >= this.capacity {
        last := this.list.Back()
        delete(this.cache, last.Value.(*pair).key)
        this.list.Remove(last)
    }

    elem := this.list.PushFront(&pair{key, value})
    this.cache[key] = elem
}