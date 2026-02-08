func numSubstringsWithOnlyOnes(s string) int {
	count := 0
	res := 0
	for i := 0; i < len(s); i++ {
		if s[i] == '1' {
			count++
		} else {
			res += count * (count + 1) / 2
			count = 0
		}
	}
	res += count * (count + 1) / 2
	return res
}