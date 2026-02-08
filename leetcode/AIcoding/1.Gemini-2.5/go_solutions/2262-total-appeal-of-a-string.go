func appealSum(s string) int64 {
	n := len(s)
	var totalAppeal int64
	lastPos := make([]int, 26)
	for i := range lastPos {
		lastPos[i] = -1
	}

	for i := 0; i < n; i++ {
		charIndex := s[i] - 'a'
		totalAppeal += int64(i-lastPos[charIndex]) * int64(n-i)
		lastPos[charIndex] = i
	}

	return totalAppeal
}