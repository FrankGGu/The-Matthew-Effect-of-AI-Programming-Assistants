func isTransformable(s string, t string) bool {
	n := len(s)
	m := len(t)
	if n != m {
		return false
	}

	pos := make([][]int, 10)
	for i := 0; i < n; i++ {
		digit := int(s[i] - '0')
		pos[digit] = append(pos[digit], i)
	}

	idx := make([]int, 10)
	for i := 0; i < m; i++ {
		digit := int(t[i] - '0')
		if idx[digit] >= len(pos[digit]) {
			return false
		}
		for j := 0; j < digit; j++ {
			if idx[j] < len(pos[j]) && pos[j][idx[j]] < pos[digit][idx[digit]] {
				return false
			}
		}
		idx[digit]++
	}

	return true
}