type NumArray struct {
	nums []int
	tree []int
	n    int
}

func Constructor(nums []int) NumArray {
	n := len(nums)
	tree := make([]int, n+1)
	arr := NumArray{nums: nums, tree: tree, n: n}
	for i := 0; i < n; i++ {
		arr.updateTree(i, nums[i])
	}
	return arr
}

func (this *NumArray) updateTree(i int, val int) {
	i++
	for i <= this.n {
		this.tree[i] += val
		i += i & (-i)
	}
}

func (this *NumArray) Update(index int, val int) {
	diff := val - this.nums[index]
	this.nums[index] = val
	this.updateTree(index, diff)
}

func (this *NumArray) sumRangeTree(i int) int {
	i++
	sum := 0
	for i > 0 {
		sum += this.tree[i]
		i -= i & (-i)
	}
	return sum
}

func (this *NumArray) SumRange(left int, right int) int {
	return this.sumRangeTree(right) - this.sumRangeTree(left-1)
}