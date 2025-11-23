package main

import "container/list"

type LRUCache struct {
    capacity int
    cache    map[int]*list.Element
    lru      *list.List
}

type entry struct {
    key   int
    value int
}

func Constructor(capacity int) LRUCache {
    return LRUCache{
        capacity: capacity,
        cache:    make(map[int]*list.Element),
        lru:      list.New(),
    }
}

func (this *LRUCache) Get(key int) int {
    if elem, found := this.cache[key]; found {
        this.lru.MoveToFront(elem)
        return elem.Value.(entry).value
    }
    return -1
}

func (this *LRUCache) Put(key int, value int) {
    if elem, found := this.cache[key]; found {
        elem.Value = entry{key, value}
        this.lru.MoveToFront(elem)
    } else {
        if this.lru.Len() >= this.capacity {
            backElem := this.lru.Back()
            if backElem != nil {
                this.lru.Remove(backElem)
                delete(this.cache, backElem.Value.(entry).key)
            }
        }
        newElem := this.lru.PushFront(entry{key, value})
        this.cache[key] = newElem
    }
}