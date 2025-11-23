func minOperations(nums []int, k int) int {
	collected := make([]bool, k+1)
	count := 0
	operations := 0

	for i := len(nums) - 1; i >= 0; i-- {
		operations++
		num := nums[i]
		if num >= 1 && num <= k {
			if !collected[num] {
				collected[num] = true
				count++
				if count == k {
					return operations
				}
			}
		}
	}
	return operations // Should not be reached if k is valid and elements are present
}