type KthLargest struct {
    nums []int
    k    int
}

func Constructor(k int, nums []int) KthLargest {
    kl := KthLargest{k: k}
    kl.nums = append(kl.nums, nums...)
    sort.Ints(kl.nums)
    return kl
}

func (this *KthLargest) Add(val int) int {
    this.nums = append(this.nums, val)
    sort.Ints(this.nums)
    return this.nums[len(this.nums)-this.k]
}