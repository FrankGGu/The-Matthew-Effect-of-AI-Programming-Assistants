func movesToStamp(stamp string, target string) []int {
	s := []byte(stamp)
	t := []byte(target)
	m, n := len(s), len(t)
	res := []int{}
	visited := make([]bool, n)
	count := 0

	for count < n {
		found := false
		for i := 0; i <= n-m; i++ {
			if !visited[i] && canReplace(s, t, i) {
				count = doReplace(s, t, i, count)
				visited[i] = true
				res = append(res, i)
				found = true
			}
		}
		if !found {
			return []int{}
		}
	}

	for i, j := 0, len(res)-1; i < j; i, j = i+1, j-1 {
		res[i], res[j] = res[j], res[i]
	}

	return res
}

func canReplace(stamp []byte, target []byte, pos int) bool {
	m := len(stamp)
	can := false
	for i := 0; i < m; i++ {
		if target[pos+i] == '?' || target[pos+i] == stamp[i] {
			if target[pos+i] == stamp[i] {
				can = true
			}
		} else {
			return false
		}
	}
	return can
}

func doReplace(stamp []byte, target []byte, pos int, count int) int {
	m := len(stamp)
	for i := 0; i < m; i++ {
		if target[pos+i] != '?' {
			target[pos+i] = '?'
			count++
		}
	}
	return count
}