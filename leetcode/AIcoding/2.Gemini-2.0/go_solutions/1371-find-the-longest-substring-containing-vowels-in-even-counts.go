func findTheLongestSubstring(s string) int {
	state := 0
	pos := make([]int, 32)
	for i := range pos {
		pos[i] = -1
	}
	pos[0] = 0
	ans := 0
	for i := 0; i < len(s); i++ {
		switch s[i] {
		case 'a':
			state ^= 1
		case 'e':
			state ^= 2
		case 'i':
			state ^= 4
		case 'o':
			state ^= 8
		case 'u':
			state ^= 16
		}
		if pos[state] == -1 {
			pos[state] = i + 1
		} else {
			ans = max(ans, i+1-pos[state])
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}