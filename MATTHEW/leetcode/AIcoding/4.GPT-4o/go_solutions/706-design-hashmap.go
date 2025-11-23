type MyHashMap struct {
    data [][][2]int
    size int
}

func Constructor() MyHashMap {
    return MyHashMap{
        data: make([][][2]int, 1000),
        size: 1000,
    }
}

func (this *MyHashMap) Put(key int, value int) {
    index := key % this.size
    for i, kv := range this.data[index] {
        if kv[0] == key {
            this.data[index][i][1] = value
            return
        }
    }
    this.data[index] = append(this.data[index], [2]int{key, value})
}

func (this *MyHashMap) Get(key int) int {
    index := key % this.size
    for _, kv := range this.data[index] {
        if kv[0] == key {
            return kv[1]
        }
    }
    return -1
}

func (this *MyHashMap) Remove(key int) {
    index := key % this.size
    for i, kv := range this.data[index] {
        if kv[0] == key {
            this.data[index] = append(this.data[index][:i], this.data[index][i+1:]...)
            return
        }
    }
}