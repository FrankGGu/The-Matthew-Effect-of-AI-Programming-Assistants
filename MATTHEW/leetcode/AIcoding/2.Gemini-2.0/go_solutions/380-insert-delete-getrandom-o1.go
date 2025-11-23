import "math/rand"

type RandomizedSet struct {
	nums []int
	idx map[int]int
}

func Constructor() RandomizedSet {
	return RandomizedSet{
		nums: []int{},
		idx:  make(map[int]int),
	}
}

func (this *RandomizedSet) Insert(val int) bool {
	if _, ok := this.idx[val]; ok {
		return false
	}
	this.nums = append(this.nums, val)
	this.idx[val] = len(this.nums) - 1
	return true
}

func (this *RandomizedSet) Remove(val int) bool {
	if _, ok := this.idx[val]; !ok {
		return false
	}
	index := this.idx[val]
	last := this.nums[len(this.nums)-1]
	this.nums[index] = last
	this.idx[last] = index
	this.nums = this.nums[:len(this.nums)-1]
	delete(this.idx, val)
	return true
}

func (this *RandomizedSet) GetRandom() int {
	return this.nums[rand.Intn(len(this.nums))]
}