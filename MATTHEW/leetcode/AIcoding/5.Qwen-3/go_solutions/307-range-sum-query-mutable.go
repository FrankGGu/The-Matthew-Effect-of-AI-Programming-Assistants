package main

type NumArray struct {
    nums   []int
    tree   []int
}

func Constructor(nums []int) NumArray {
    n := len(nums)
    tree := make([]int, n+1)
    for i := 0; i < n; i++ {
        update(tree, i+1, nums[i])
    }
    return NumArray{nums, tree}
}

func update(tree []int, index int, value int) {
    for index < len(tree) {
        tree[index] += value
        index += index & -index
    }
}

func (this *NumArray) Update(index int, val int) {
    diff := val - this.nums[index]
    this.nums[index] = val
    update(this.tree, index+1, diff)
}

func query(tree []int, index int) int {
    res := 0
    for index > 0 {
        res += tree[index]
        index -= index & -index
    }
    return res
}

func (this *NumArray) SumRange(left int, right int) int {
    return query(this.tree, right+1) - query(this.tree, left)
}