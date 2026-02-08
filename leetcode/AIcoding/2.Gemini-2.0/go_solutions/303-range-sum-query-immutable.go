type NumArray struct {
    sums []int
}

func Constructor(nums []int) NumArray {
    sums := make([]int, len(nums)+1)
    for i := 0; i < len(nums); i++ {
        sums[i+1] = sums[i] + nums[i]
    }
    return NumArray{sums: sums}
}

func (this *NumArray) SumRange(left int, right int) int {
    return this.sums[right+1] - this.sums[left]
}