func checkRecord(s string) bool {
	absentCount := 0
	for i := 0; i < len(s); i++ {
		if s[i] == 'A' {
			absentCount++
			if absentCount > 1 {
				return false
			}
		} else if s[i] == 'L' {
			if i > 1 && s[i-1] == 'L' && s[i-2] == 'L' {
				return false
			}
		}
	}
	return true
}