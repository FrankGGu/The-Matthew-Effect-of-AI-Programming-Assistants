type MyHashSet struct {
    buckets [][]int
    size    int
}

func Constructor() MyHashSet {
    return MyHashSet{
        buckets: make([][]int, 1000),
        size:    1000,
    }
}

func (this *MyHashSet) Add(key int) {
    bucket := key % this.size
    for _, v := range this.buckets[bucket] {
        if v == key {
            return
        }
    }
    this.buckets[bucket] = append(this.buckets[bucket], key)
}

func (this *MyHashSet) Remove(key int) {
    bucket := key % this.size
    for i, v := range this.buckets[bucket] {
        if v == key {
            this.buckets[bucket] = append(this.buckets[bucket][:i], this.buckets[bucket][i+1:]...)
            return
        }
    }
}

func (this *MyHashSet) Contains(key int) bool {
    bucket := key % this.size
    for _, v := range this.buckets[bucket] {
        if v == key {
            return true
        }
    }
    return false
}