func removeAlmostEqualCharacters(s string) int {
	count := 0
	for i := 0; i < len(s)-1; i++ {
		if abs(int(s[i])-int(s[i+1])) <= 1 {
			count++
			i++
		}
	}
	return count
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}