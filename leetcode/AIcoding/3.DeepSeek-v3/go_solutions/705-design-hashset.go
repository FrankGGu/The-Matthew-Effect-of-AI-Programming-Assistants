type MyHashSet struct {
    data []bool
}

func Constructor() MyHashSet {
    return MyHashSet{
        data: make([]bool, 1000001),
    }
}

func (this *MyHashSet) Add(key int) {
    this.data[key] = true
}

func (this *MyHashSet) Remove(key int) {
    this.data[key] = false
}

func (this *MyHashSet) Contains(key int) bool {
    return this.data[key]
}