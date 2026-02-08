func countAndSay(n int) string {
	if n == 1 {
		return "1"
	}
	prev := countAndSay(n - 1)
	result := ""
	count := 1
	for i := 0; i < len(prev); i++ {
		if i+1 < len(prev) && prev[i] == prev[i+1] {
			count++
		} else {
			result += string(rune(count+'0')) + string(prev[i])
			count = 1
		}
	}
	return result
}