package main

type NumArray struct {
    prefixSums []int
}

func Constructor(nums []int) NumArray {
    n := len(nums)
    prefixSums := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefixSums[i+1] = prefixSums[i] + nums[i]
    }
    return NumArray{prefixSums}
}

func (this *NumArray) SumRange(left int, right int) int {
    return this.prefixSums[right+1] - this.prefixSums[left]
}