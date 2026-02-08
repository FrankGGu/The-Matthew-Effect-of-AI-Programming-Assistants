func secondsToRemoveOccurrences(s string) int {
	seconds := 0
	for {
		changed := false
		newS := []byte(s)
		for i := 0; i < len(s)-1; i++ {
			if s[i] == '0' && s[i+1] == '1' {
				newS[i], newS[i+1] = '1', '0'
				changed = true
			}
		}
		s = string(newS)
		if !changed {
			break
		}
		seconds++
	}
	return seconds
}