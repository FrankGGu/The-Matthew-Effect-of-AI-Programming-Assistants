func attendanceRecordI(s string) bool {
	absentCount := 0
	lateCount := 0
	for i := 0; i < len(s); i++ {
		if s[i] == 'A' {
			absentCount++
			if absentCount >= 2 {
				return false
			}
		}
		if s[i] == 'L' {
			lateCount++
			if lateCount >= 3 {
				return false
			}
		} else {
			lateCount = 0
		}
	}
	return true
}