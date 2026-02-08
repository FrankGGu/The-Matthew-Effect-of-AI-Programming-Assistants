func canTransform(initial string, target string) bool {
	n := len(initial)
	i, j := 0, 0
	for i < n || j < n {
		for i < n && initial[i] == '0' {
			i++
		}
		for j < n && target[j] == '0' {
			j++
		}
		if i == n && j == n {
			return true
		}
		if i == n || j == n {
			return false
		}
		if initial[i] != target[j] {
			return false
		}
		if initial[i] == 'A' {
			if i < j {
				return false
			}
		} else {
			if i > j {
				return false
			}
		}
		i++
		j++
	}
	return true
}