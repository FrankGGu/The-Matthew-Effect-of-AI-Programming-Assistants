func maximumRemovals(s string, p string, removable []int) int {
	n := len(s)
	m := len(p)
	l := 0
	r := len(removable)
	ans := 0

	check := func(mid int) bool {
		removed := make(map[int]bool)
		for i := 0; i < mid; i++ {
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

	for l <= r {
		mid := l + (r-l)/2
		if check(mid) {
			ans = mid
			l = mid + 1
		} else {
			r = mid - 1
		}
	}

	return ans
}