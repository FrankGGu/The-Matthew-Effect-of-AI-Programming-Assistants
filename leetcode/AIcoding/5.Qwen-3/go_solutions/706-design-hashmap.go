package main

type MyHashMap struct {
    data []int
}

func Constructor() MyHashMap {
    return MyHashMap{
        data: make([]int, 1000000),
    }
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