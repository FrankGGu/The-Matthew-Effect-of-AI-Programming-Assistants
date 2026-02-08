import "sort"

func minCost(nums []int, cost []int) int64 {
	n := len(nums)
	l, r := nums[0], nums[0]
	for i := 1; i < n; i++ {
		if nums[i] < l {
			l = nums[i]
		}
		if nums[i] > r {
			r = nums[i]
		}
	}

	check := func(x int) int64 {
		res := int64(0)
		for i := 0; i < n; i++ {
			res += int64(abs(nums[i]-x) * cost[i])
		}
		return res
	}

	ans := int64(1e18)
	for l < r {
		mid := (l + r) / 2
		ans1 := check(mid)
		ans2 := check(mid + 1)
		ans = min(ans1, ans2)
		if ans1 < ans2 {
			r = mid
		} else {
			l = mid + 1
		}
	}

	return check(l)
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}