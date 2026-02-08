func maximumRemovals(s string, p string, removable []int) int {
	n := len(s)
	m := len(p)
	r := len(removable)

	check := func(k int) bool {
		removed := make([]bool, n)
		for i := 0; i < k; i++ {
			removed[removable[i]] = true
		}

		sFiltered := ""
		for i := 0; i < n; i++ {
			if !removed[i] {
				sFiltered += string(s[i])
			}
		}

		i := 0
		j := 0
		for i < len(sFiltered) && j < m {
			if sFiltered[i] == p[j] {
				j++
			}
			i++
		}

		return j == m
	}

	left := 0
	right := r
	ans := 0

	for left <= right {
		mid := left + (right-left)/2
		if check(mid) {
			ans = mid
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	return ans
}