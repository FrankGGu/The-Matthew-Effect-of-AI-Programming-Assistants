package main

type RandomizedSet struct {
    nums  []int
    index map[int]int
}

func Constructor() RandomizedSet {
    return RandomizedSet{
        nums:  make([]int, 0),
        index: make(map[int]int),
    }
}

func (this *RandomizedSet) Insert(val int) bool {
    if _, exists := this.index[val]; exists {
        return false
    }
    this.index[val] = len(this.nums)
    this.nums = append(this.nums, val)
    return true
}

func (this *RandomizedSet) Remove(val int) bool {
    if _, exists := this.index[val]; !exists {
        return false
    }
    idx := this.index[val]
    last := this.nums[len(this.nums)-1]
    this.nums[idx] = last
    this.index[last] = idx
    delete(this.index, val)
    this.nums = this.nums[:len(this.nums)-1]
    return true
}

func (this *RandomizedSet) GetRandom() int {
    return this.nums[rand.Intn(len(this.nums))]
}