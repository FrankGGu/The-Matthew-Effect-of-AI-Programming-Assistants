func minSteps(s string, t string) int {
	freq := make(map[rune]int)
	for _, r := range s {
		freq[r]++
	}
	for _, r := range t {
		freq[r]--
	}
	count := 0
	for _, v := range freq {
		count += abs(v)
	}
	return count
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}