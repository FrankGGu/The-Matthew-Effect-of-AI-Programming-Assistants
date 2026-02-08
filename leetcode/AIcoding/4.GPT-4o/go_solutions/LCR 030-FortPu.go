package random

import "math/rand"

type RandomizedSet struct {
    nums []int
    idx  map[int]int
}

/** Initialize your data structure here. */
func Constructor() RandomizedSet {
    return RandomizedSet{
        nums: []int{},
        idx:  make(map[int]int),
    }
}

/** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
func (this *RandomizedSet) Insert(val int) bool {
    if _, found := this.idx[val]; found {
        return false
    }
    this.nums = append(this.nums, val)
    this.idx[val] = len(this.nums) - 1
    return true
}

/** Removes a value from the set. Returns true if the set contained the specified element. */
func (this *RandomizedSet) Remove(val int) bool {
    if index, found := this.idx[val]; found {
        lastElem := this.nums[len(this.nums)-1]
        this.nums[index] = lastElem
        this.idx[lastElem] = index
        this.nums = this.nums[:len(this.nums)-1]
        delete(this.idx, val)
        return true
    }
    return false
}

/** Get a random element from the set. */
func (this *RandomizedSet) GetRandom() int {
    return this.nums[rand.Intn(len(this.nums))]
}