package main

func canTransform(s string, t string) bool {
	if len(s) != len(t) {
		return false
	}
	i, j := 0, 0
	for i < len(s) && j < len(t) {
		for i < len(s) && s[i] == 'X' {
			i++
		}
		for j < len(t) && t[j] == 'X' {
			j++
		}
		if i < len(s) && j < len(t) {
			if s[i] != t[j] {
				return false
			}
			if s[i] == 'L' && i < j {
				return false
			}
			if s[i] == 'R' && i > j {
				return false
			}
			i++
			j++
		} else {
			break
		}
	}
	return true
}