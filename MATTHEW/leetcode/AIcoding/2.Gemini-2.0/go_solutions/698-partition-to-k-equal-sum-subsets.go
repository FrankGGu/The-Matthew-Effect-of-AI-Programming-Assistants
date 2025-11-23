func canPartitionKSubsets(nums []int, k int) bool {
	sum := 0
	maxNum := 0
	for _, num := range nums {
		sum += num
		if num > maxNum {
			maxNum = num
		}
	}

	if sum%k != 0 {
		return false
	}

	target := sum / k
	if maxNum > target {
		return false
	}

	used := make([]bool, len(nums))
	return canPartition(nums, used, 0, k, 0, target)
}

func canPartition(nums []int, used []bool, start int, k int, curSum int, target int) bool {
	if k == 1 {
		return true
	}

	if curSum == target {
		return canPartition(nums, used, 0, k-1, 0, target)
	}

	for i := start; i < len(nums); i++ {
		if !used[i] {
			used[i] = true
			if canPartition(nums, used, i+1, k, curSum+nums[i], target) {
				return true
			}
			used[i] = false
		}
	}

	return false
}