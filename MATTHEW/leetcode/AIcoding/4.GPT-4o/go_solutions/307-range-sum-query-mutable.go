type NumArray struct {
    nums []int
    tree []int
    n    int
}

func Constructor(nums []int) NumArray {
    n := len(nums)
    tree := make([]int, n+1)
    numArray := NumArray{nums: nums, tree: tree, n: n}
    for i := 0; i < n; i++ {
        numArray.Update(i, nums[i])
    }
    return numArray
}

func (this *NumArray) Update(i int, val int) {
    diff := val - this.nums[i]
    this.nums[i] = val
    for j := i + 1; j <= this.n; j++ {
        this.tree[j] += diff
    }
}

func (this *NumArray) SumRange(i int, j int) int {
    return this.tree[j+1] - this.tree[i]
}