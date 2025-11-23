type MyHashMap struct {
	data []int
}

func Constructor() MyHashMap {
	return MyHashMap{
		data: make([]int, 1000001),
	}
}

func (this *MyHashMap) Put(key int, value int) {
	this.data[key] = value + 1 
}

func (this *MyHashMap) Get(key int) int {
	val := this.data[key]
	if val == 0 {
		return -1
	}
	return val - 1
}

func (this *MyHashMap) Remove(key int) {
	this.data[key] = 0
}