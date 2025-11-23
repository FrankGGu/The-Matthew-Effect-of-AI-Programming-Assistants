import (
	"math/rand"
)

type RandomizedSet struct {
	nums []int
	valToIndex map[int]int
}

func Constructor() RandomizedSet {
	return RandomizedSet{
		nums:       make([]int, 0),
		valToIndex: make(map[int]int),
	}
}

func (this *RandomizedSet) Insert(val int) bool {
	if _, exists := this.valToIndex[val]; exists {
		return false
	}
	this.valToIndex[val] = len(this.nums)
	this.nums = append(this.nums, val)
	return true
}

func (this *RandomizedSet) Remove(val int) bool {
	index, exists := this.valToIndex[val]
	if !exists {
		return false
	}
	lastVal := this.nums[len(this.nums)-1]
	this.nums[index] = lastVal
	this.valToIndex[lastVal] = index
	this.nums = this.nums[:len(this.nums)-1]
	delete(this.valToIndex, val)
	return true
}

func (this *RandomizedSet) GetRandom() int {
	return this.nums[rand.Intn(len(this.nums))]
}