func minSizeSubarray(nums []int, target int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}

	k := target / sum
	target %= sum
	ans := k * len(nums)

	if target == 0 {
		return ans
	}

	minLen := len(nums) + 1
	left, currSum := 0, 0
	for right := 0; right < 2*len(nums); right++ {
		currSum += nums[right%len(nums)]
		for currSum > target {
			currSum -= nums[left%len(nums)]
			left++
		}
		if currSum == target {
			minLen = min(minLen, right-left+1)
		}
	}

	if minLen == len(nums)+1 {
		return -1
	}

	return ans + minLen
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}