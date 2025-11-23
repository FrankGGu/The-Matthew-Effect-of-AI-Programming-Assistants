package main

type AllOne struct {
    buckets map[int]*Bucket
    keys    map[string]int
    max     int
}

type Bucket struct {
    count int
    keys  map[string]bool
}

func Constructor() AllOne {
    return AllOne{
        buckets: make(map[int]*Bucket),
        keys:    make(map[string]int),
        max:     0,
    }
}

func (this *AllOne) Inc(key string) {
    if count, ok := this.keys[key]; ok {
        this.moveKey(key, count, count+1)
    } else {
        this.keys[key] = 1
        if bucket, ok := this.buckets[1]; ok {
            bucket.keys[key] = true
        } else {
            this.buckets[1] = &Bucket{count: 1, keys: map[string]bool{key: true}}
        }
        if this.max < 1 {
            this.max = 1
        }
    }
}

func (this *AllOne) Dec(key string) {
    count := this.keys[key]
    if count == 1 {
        delete(this.keys, key)
        this.removeKeyFromBucket(key, count)
    } else {
        this.moveKey(key, count, count-1)
    }
}

func (this *AllOne) GetMaxKey() string {
    if this.max == 0 {
        return ""
    }
    for key := range this.buckets[this.max].keys {
        return key
    }
    return ""
}

func (this *AllOne) GetMinKey() string {
    for count := 1; count <= this.max; count++ {
        if bucket, ok := this.buckets[count]; ok {
            for key := range bucket.keys {
                return key
            }
        }
    }
    return ""
}

func (this *AllOne) moveKey(key string, fromCount, toCount int) {
    this.removeKeyFromBucket(key, fromCount)
    this.keys[key] = toCount
    if bucket, ok := this.buckets[toCount]; ok {
        bucket.keys[key] = true
    } else {
        this.buckets[toCount] = &Bucket{count: toCount, keys: map[string]bool{key: true}}
    }
    if toCount > this.max {
        this.max = toCount
    }
}

func (this *AllOne) removeKeyFromBucket(key string, count int) {
    bucket := this.buckets[count]
    delete(bucket.keys, key)
    if len(bucket.keys) == 0 {
        delete(this.buckets, count)
        if count == this.max {
            this.max--
        }
    }
}