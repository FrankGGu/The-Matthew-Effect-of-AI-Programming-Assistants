func lengthLongestPath(input string) int {
	maxLen := 0
	pathLen := make(map[int]int)
	pathLen[-1] = 0
	for _, line := range strings.Split(input, "\n") {
		name := line
		depth := 0
		for i, c := range line {
			if c == '\t' {
				depth++
			} else {
				name = line[i:]
				break
			}
		}
		length := len(name)
		if strings.Contains(name, ".") {
			maxLen = max(maxLen, pathLen[depth-1]+length+1)
		} else {
			pathLen[depth] = pathLen[depth-1] + length + 1
		}
	}
	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}