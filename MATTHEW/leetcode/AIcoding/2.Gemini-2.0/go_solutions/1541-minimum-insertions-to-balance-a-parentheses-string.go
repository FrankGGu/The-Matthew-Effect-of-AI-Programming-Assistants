func minInsertions(s string) int {
	res := 0
	right := 0
	for i := 0; i < len(s); i++ {
		if s[i] == '(' {
			if right > 0 {
				right--
			} else {
				res++
			}
			right += 2
		} else {
			right--
			if right < 0 {
				res++
				right += 2
			}
		}
	}
	res += right
	return res
}