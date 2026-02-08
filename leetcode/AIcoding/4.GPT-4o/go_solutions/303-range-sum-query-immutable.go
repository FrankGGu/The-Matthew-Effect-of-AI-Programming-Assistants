type NumArray struct {
    sums []int
}

func Constructor(nums []int) NumArray {
    n := len(nums)
    sums := make([]int, n+1)
    for i := 0; i < n; i++ {
        sums[i+1] = sums[i] + nums[i]
    }
    return NumArray{sums}
}

func (this *NumArray) SumRange(left int, right int) int {
    return this.sums[right+1] - this.sums[left]
}