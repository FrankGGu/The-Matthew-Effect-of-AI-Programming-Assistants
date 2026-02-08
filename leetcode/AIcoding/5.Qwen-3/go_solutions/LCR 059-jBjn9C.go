package main

type KthLargest struct {
    nums []int
    k    int
}

func Constructor(k int, nums []int) KthLargest {
    return KthLargest{k: k, nums: nums}
}

func (this *KthLargest) Add(val int) int {
    this.nums = append(this.nums, val)
    sort.Ints(this.nums)
    return this.nums[len(this.nums)-this.k]
}