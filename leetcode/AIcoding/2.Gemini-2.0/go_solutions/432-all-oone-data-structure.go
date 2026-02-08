type Bucket struct {
    keys map[string]bool
    count int
    prev *Bucket
    next *Bucket
}

type AllOne struct {
    head *Bucket
    tail *Bucket
    keyToBucket map[string]*Bucket
}

func Constructor() AllOne {
    head := &Bucket{count: 0, keys: make(map[string]bool)}
    tail := &Bucket{count: 0, keys: make(map[string]bool)}
    head.next = tail
    tail.prev = head
    return AllOne{head: head, tail: tail, keyToBucket: make(map[string]*Bucket)}
}

func (this *AllOne) Inc(key string)  {
    if bucket, ok := this.keyToBucket[key]; ok {
        nextCount := bucket.count + 1
        nextBucket := bucket.next
        if nextBucket.count != nextCount {
            nextBucket = &Bucket{count: nextCount, keys: make(map[string]bool)}
            this.insertAfter(bucket, nextBucket)
        }
        nextBucket.keys[key] = true
        delete(bucket.keys, key)
        delete(this.keyToBucket, key)
        this.keyToBucket[key] = nextBucket
        if len(bucket.keys) == 0 && bucket != this.head {
            this.removeBucket(bucket)
        }
    } else {
        if this.head.next.count != 1 {
            newBucket := &Bucket{count: 1, keys: make(map[string]bool)}
            this.insertAfter(this.head, newBucket)
        }
        this.head.next.keys[key] = true
        this.keyToBucket[key] = this.head.next
    }
}

func (this *AllOne) Dec(key string)  {
    bucket := this.keyToBucket[key]
    delete(bucket.keys, key)
    delete(this.keyToBucket, key)
    prevCount := bucket.count - 1
    if prevCount > 0 {
        prevBucket := bucket.prev
        if prevBucket.count != prevCount {
            prevBucket = &Bucket{count: prevCount, keys: make(map[string]bool)}
            this.insertAfter(bucket.prev.prev, prevBucket)
        }
        prevBucket.keys[key] = true
        this.keyToBucket[key] = prevBucket
    }
    if len(bucket.keys) == 0 && bucket != this.head && bucket != this.tail {
        this.removeBucket(bucket)
    }
}

func (this *AllOne) GetMaxKey() string {
    if this.tail.prev == this.head {
        return ""
    }
    for key := range this.tail.prev.keys {
        return key
    }
    return ""
}

func (this *AllOne) GetMinKey() string {
    if this.head.next == this.tail {
        return ""
    }
    for key := range this.head.next.keys {
        return key
    }
    return ""
}

func (this *AllOne) insertAfter(bucket *Bucket, newBucket *Bucket) {
    newBucket.next = bucket.next
    newBucket.prev = bucket
    bucket.next.prev = newBucket
    bucket.next = newBucket
}

func (this *AllOne) removeBucket(bucket *Bucket) {
    bucket.prev.next = bucket.next
    bucket.next.prev = bucket.prev
}