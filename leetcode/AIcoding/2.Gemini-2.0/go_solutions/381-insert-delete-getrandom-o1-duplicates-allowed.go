import "math/rand"

type RandomizedCollection struct {
	nums []int
	idx  map[int][]int
}

func Constructor() RandomizedCollection {
	return RandomizedCollection{
		nums: []int{},
		idx:  make(map[int][]int),
	}
}

func (this *RandomizedCollection) Insert(val int) bool {
	this.nums = append(this.nums, val)
	this.idx[val] = append(this.idx[val], len(this.nums)-1)
	return len(this.idx[val]) == 1
}

func (this *RandomizedCollection) Remove(val int) bool {
	if _, ok := this.idx[val]; !ok {
		return false
	}
	i := this.idx[val][len(this.idx[val])-1]
	this.idx[val] = this.idx[val][:len(this.idx[val])-1]
	if len(this.idx[val]) == 0 {
		delete(this.idx, val)
	}
	if i == len(this.nums)-1 {
		this.nums = this.nums[:len(this.nums)-1]
		return true
	}
	last := this.nums[len(this.nums)-1]
	this.nums[i] = last
	this.nums = this.nums[:len(this.nums)-1]
	for j, v := range this.idx[last] {
		if v == len(this.nums) {
			this.idx[last][j] = i
			break
		}
	}
	return true
}

func (this *RandomizedCollection) GetRandom() int {
	return this.nums[rand.Intn(len(this.nums))]
}