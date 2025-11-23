import "math/rand"

type RandomizedSet struct {
	nums   []int
	idxMap map[int]int
}

func Constructor() RandomizedSet {
	return RandomizedSet{
		nums:   make([]int, 0),
		idxMap: make(map[int]int),
	}
}

func (this *RandomizedSet) Insert(val int) bool {
	if _, ok := this.idxMap[val]; ok {
		return false
	}
	this.nums = append(this.nums, val)
	this.idxMap[val] = len(this.nums) - 1
	return true
}

func (this *RandomizedSet) Remove(val int) bool {
	idx, ok := this.idxMap[val]
	if !ok {
		return false
	}
	last := this.nums[len(this.nums)-1]
	this.nums[idx] = last
	this.nums = this.nums[:len(this.nums)-1]
	this.idxMap[last] = idx
	delete(this.idxMap, val)
	return true
}

func (this *RandomizedSet) GetRandom() int {
	return this.nums[rand.Intn(len(this.nums))]
}