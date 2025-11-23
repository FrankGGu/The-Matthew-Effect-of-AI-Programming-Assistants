type MyHashSet struct {
    buckets []list.List
    size    int
}

import "container/list"

func Constructor() MyHashSet {
    return MyHashSet{
        buckets: make([]list.List, 1000),
        size:    1000,
    }
}

func (this *MyHashSet) Add(key int) {
    index := key % this.size
    for e := this.buckets[index].Front(); e != nil; e = e.Next() {
        if e.Value == key {
            return
        }
    }
    this.buckets[index].PushBack(key)
}

func (this *MyHashSet) Remove(key int) {
    index := key % this.size
    for e := this.buckets[index].Front(); e != nil; e = e.Next() {
        if e.Value == key {
            this.buckets[index].Remove(e)
            return
        }
    }
}

func (this *MyHashSet) Contains(key int) bool {
    index := key % this.size
    for e := this.buckets[index].Front(); e != nil; e = e.Next() {
        if e.Value == key {
            return true
        }
    }
    return false
}