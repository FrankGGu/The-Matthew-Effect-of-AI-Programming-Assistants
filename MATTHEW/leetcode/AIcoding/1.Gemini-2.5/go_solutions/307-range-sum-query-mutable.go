type NumArray struct {
	bit  []int
	nums []int
	n    int
}

func Constructor(nums []int) NumArray {
	n := len(nums)
	na := NumArray{
		bit:  make([]int, n+1), // Fenwick tree is 1-indexed
		nums: make([]int, n),   // Original array is 0-indexed
		n:    n,
	}

	for i := 0; i < n; i++ {
		na.Update(i, nums[i])
	}
	return na
}

func (this *NumArray) Update(index int, val int) {
	delta := val - this.nums[index]
	this.nums[index] = val

	// Update Fenwick tree
	idx := index + 1 // Convert to 1-indexed
	for idx <= this.n {
		this.bit[idx] += delta
		idx += idx & (-idx) // Move to the next parent
	}
}

func (this *NumArray) queryPrefixSum(index int) int {
	sum := 0
	idx := index + 1 // Convert to 1-indexed
	for idx > 0 {
		sum += this.bit[idx]
		idx -= idx & (-idx) // Move to the previous prefix
	}
	return sum
}

func (this *NumArray) SumRange(left int, right int) int {
	// Sum from 0 to right - Sum from 0 to left-1
	return this.queryPrefixSum(right) - this.queryPrefixSum(left-1)
}