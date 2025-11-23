func findTheIntegerAddedToArray(nums []int, k int) int {
	l := 0
	r := 1000000000
	ans := 0
	for l <= r {
		mid := l + (r-l)/2
		count := 0
		for _, num := range nums {
			if num <= mid {
				count++
			}
		}
		if mid-count >= k {
			ans = mid
			r = mid - 1
		} else {
			l = mid + 1
		}
	}
	return ans
}