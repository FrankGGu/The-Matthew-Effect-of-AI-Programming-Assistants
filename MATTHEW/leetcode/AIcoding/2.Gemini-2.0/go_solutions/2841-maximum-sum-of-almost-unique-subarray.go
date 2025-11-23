func maxSum(nums []int, m int, k int) int64 {
	n := len(nums)
	if n < k {
		return 0
	}

	var ans int64
	var currSum int64
	freq := make(map[int]int)
	uniqueCount := 0

	for i := 0; i < k; i++ {
		if freq[nums[i]] == 0 {
			uniqueCount++
		}
		freq[nums[i]]++
		currSum += int64(nums[i])
	}

	if uniqueCount >= m {
		ans = currSum
	}

	for i := k; i < n; i++ {
		currSum -= int64(nums[i-k])
		freq[nums[i-k]]--
		if freq[nums[i-k]] == 0 {
			uniqueCount--
		}

		if freq[nums[i]] == 0 {
			uniqueCount++
		}
		freq[nums[i]]++
		currSum += int64(nums[i])

		if uniqueCount >= m {
			if currSum > ans {
				ans = currSum
			}
		}
	}

	return ans
}