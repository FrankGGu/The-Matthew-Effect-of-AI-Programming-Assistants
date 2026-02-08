func canChange(start string, target string) bool {
	i, j := 0, 0
	for i < len(start) && j < len(target) {
		for i < len(start) && start[i] == '_' {
			i++
		}
		for j < len(target) && target[j] == '_' {
			j++
		}

		if i < len(start) && j < len(target) {
			if start[i] != target[j] {
				return false
			}
			if start[i] == 'L' {
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
	}

	for i < len(start) {
		if start[i] != '_' {
			return false
		}
		i++
	}
	for j < len(target) {
		if target[j] != '_' {
			return false
		}
		j++
	}

	return true
}