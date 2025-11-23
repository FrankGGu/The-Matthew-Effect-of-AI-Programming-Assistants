type MyHashMap struct {
    data []int
}

func Constructor() MyHashMap {
    data := make([]int, 1000001)
    for i := range data {
        data[i] = -1
    }
    return MyHashMap{data: data}
}

func (this *MyHashMap) Put(key int, value int) {
    this.data[key] = value
}

func (this *MyHashMap) Get(key int) int {
    return this.data[key]
}

func (this *MyHashMap) Remove(key int) {
    this.data[key] = -1
}