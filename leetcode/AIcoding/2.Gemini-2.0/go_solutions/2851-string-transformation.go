func canTransform(start string, end string) bool {
	if len(start) != len(end) {
		return false
	}

	i, j := 0, 0
	for i < len(start) || j < len(end) {
		for i < len(start) && start[i] == 'X' {
			i++
		}
		for j < len(end) && end[j] == 'X' {
			j++
		}

		if i == len(start) && j == len(end) {
			return true
		}
		if i == len(start) || j == len(end) {
			return false
		}

		if start[i] != end[j] {
			return false
		}

		if start[i] == 'L' && i < j {
			return false
		}

		if start[i] == 'R' && i > j {
			return false
		}

		i++
		j++
	}

	return true
}