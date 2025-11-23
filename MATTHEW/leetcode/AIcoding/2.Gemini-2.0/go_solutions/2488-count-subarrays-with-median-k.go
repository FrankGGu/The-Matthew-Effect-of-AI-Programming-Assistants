func countSubarrays(nums []int, k int) int {
	n := len(nums)
	pos := -1
	for i := 0; i < n; i++ {
		if nums[i] == k {
			pos = i
			break
		}
	}

	ans := 0
	counts := make(map[int]int)
	counts[0] = 1

	balance := 0
	for i := pos - 1; i >= 0; i-- {
		if nums[i] < k {
			balance--
		} else {
			balance++
		}
		counts[balance]++
	}

	balance = 0
	for i := pos; i < n; i++ {
		if nums[i] < k {
			balance--
		} else if nums[i] > k {
			balance++
		}

		ans += counts[-balance] + counts[1-balance]
	}

	return ans
}