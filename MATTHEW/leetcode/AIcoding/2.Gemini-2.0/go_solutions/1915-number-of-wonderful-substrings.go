func wonderfulSubstrings(word string) int64 {
	var ans int64
	count := make(map[int]int)
	count[0] = 1
	mask := 0
	for i := 0; i < len(word); i++ {
		mask ^= 1 << (word[i] - 'a')
		ans += int64(count[mask])
		for j := 0; j < 10; j++ {
			ans += int64(count[mask^(1<<j)])
		}
		count[mask]++
	}
	return ans
}