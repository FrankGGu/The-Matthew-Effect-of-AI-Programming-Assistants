import "sort"

func minimizeMax(nums []int, p int) int {
	sort.Ints(nums)
	n := len(nums)
	l, r := 0, nums[n-1]-nums[0]

	check := func(mid int) bool {
		count := 0
		i := 0
		for i < n-1 {
			if nums[i+1]-nums[i] <= mid {
				count++
				i += 2
			} else {
				i++
			}
		}
		return count >= p
	}

	ans := 0
	for l <= r {
		mid := l + (r-l)/2
		if check(mid) {
			ans = mid
			r = mid - 1
		} else {
			l = mid + 1
		}
	}

	return ans
}