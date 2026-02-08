type LRUCache struct {
    capacity int
    cache    map[int]*list.Element
    list     *list.List
}

type entry struct {
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
        return elem.Value.(*entry).value
    }
    return -1
}

func (this *LRUCache) Put(key int, value int) {
    if elem, ok := this.cache[key]; ok {
        elem.Value.(*entry).value = value
        this.list.MoveToFront(elem)
        return
    }
    if this.list.Len() == this.capacity {
        back := this.list.Back()
        delete(this.cache, back.Value.(*entry).key)
        this.list.Remove(back)
    }
    elem := this.list.PushFront(&entry{key, value})
    this.cache[key] = elem
}