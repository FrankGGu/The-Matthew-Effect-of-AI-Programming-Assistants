func maxNonOverlapping(nums []int, target int) int {
	count := 0
	sum := 0
	seen := map[int]bool{0: true}
	for i := 0; i < len(nums); i++ {
		sum += nums[i]
		if seen[sum-target] {
			count++
			sum = 0
			seen = map[int]bool{0: true}
		} else {
			seen[sum] = true
		}
	}
	return count
}