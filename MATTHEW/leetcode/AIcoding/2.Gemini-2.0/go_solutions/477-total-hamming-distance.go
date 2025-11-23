func totalHammingDistance(nums []int) int {
	n := len(nums)
	total := 0
	for i := 0; i < 32; i++ {
		count := 0
		for j := 0; j < n; j++ {
			if nums[j]&(1<<i) != 0 {
				count++
			}
		}
		total += count * (n - count)
	}
	return total
}