func canPartitionKSubsets(nums []int, k int) bool {
	sum := 0
	for _, num := range nums {
		sum += num
	}
	if sum%k != 0 {
		return false
	}
	target := sum / k
	n := len(nums)
	used := make([]bool, n)
	var backtrack func(int, int, int) bool
	backtrack = func(index int, curSum int, count int) bool {
		if count == k {
			return true
		}
		if curSum == target {
			return backtrack(0, 0, count+1)
		}
		if curSum > target {
			return false
		}
		for i := index; i < n; i++ {
			if !used[i] {
				used[i] = true
				if backtrack(i+1, curSum+nums[i], count) {
					return true
				}
				used[i] = false
			}
		}
		return false
	}
	return backtrack(0, 0, 0)
}