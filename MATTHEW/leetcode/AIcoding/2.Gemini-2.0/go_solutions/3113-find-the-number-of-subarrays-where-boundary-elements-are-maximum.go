func countSubarrays(nums []int, k int) int64 {
	n := len(nums)
	ans := int64(0)
	for i := 0; i < n; i++ {
		maxVal := nums[i]
		count := 0
		for j := i; j < n; j++ {
			maxVal = max(maxVal, nums[j])
			if maxVal == k {
				count++
			}
			if maxVal > k {
				break
			}
		}
		ans += int64(count)
	}

	count := int64(0)
	for i := 0; i < n; i++ {
		maxVal := nums[i]
		flag := false
		for j := i; j < n; j++ {
			maxVal = max(maxVal, nums[j])
			if maxVal == k {
				flag = true
			}
			if nums[i] == k && nums[j] == k && flag {
				count++
			} else if flag && nums[i] == k && maxVal == k{
				count++
			} else if flag && nums[j] == k && maxVal == k{
				count++
			}
		}
	}

	ans = 0
	for i := 0; i < n; i++ {
		maxVal := 0
		cnt := 0
		for j := i; j < n; j++ {
			maxVal = max(maxVal, nums[j])
			if maxVal == k && nums[i] <= k && nums[j] <= k {
				cnt++
			}
		}
		ans += int64(cnt)
	}

	ans2 := int64(0)
	for i := 0; i < n; i++ {
		maxVal := 0
		flag := false
		for j := i; j < n; j++ {
			maxVal = max(maxVal, nums[j])
			if maxVal == k {
				flag = true
			}
			if flag && nums[i] == k && nums[j] == k {
				ans2++
			} else if flag && nums[i] == k && maxVal == k {
				ans2++
			} else if flag && nums[j] == k && maxVal == k {
				ans2++
			} else if flag && maxVal == k {
				ans2++
			}

		}
	}

	ans = 0
	for i := 0; i < n; i++ {
		maxVal := 0
		ok := false
		for j := i; j < n; j++ {
			maxVal = max(maxVal, nums[j])
			if maxVal == k {
				ok = true
			}
			if ok && maxVal == k {
				ans++
			}
		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}