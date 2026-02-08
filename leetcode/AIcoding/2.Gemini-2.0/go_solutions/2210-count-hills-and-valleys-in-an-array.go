func countHillValley(nums []int) int {
	n := len(nums)
	if n < 3 {
		return 0
	}
	count := 0
	for i := 1; i < n-1; i++ {
		if nums[i] == nums[i-1] {
			continue
		}
		j := i + 1
		for j < n && nums[i] == nums[j] {
			j++
		}
		if j == n {
			continue
		}
		if (nums[i] > nums[i-1] && nums[i] > nums[j]) || (nums[i] < nums[i-1] && nums[i] < nums[j]) {
			count++
		}
		i = j - 1
	}
	return count
}