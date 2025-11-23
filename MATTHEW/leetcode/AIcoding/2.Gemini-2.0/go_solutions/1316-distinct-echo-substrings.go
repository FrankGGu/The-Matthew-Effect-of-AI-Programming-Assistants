func distinctEchoSubstrings(text string) int {
	n := len(text)
	seen := make(map[string]bool)
	count := 0

	for l := 1; l <= n/2; l++ {
		for i := 0; i <= n-2*l; i++ {
			sub1 := text[i : i+l]
			sub2 := text[i+l : i+2*l]
			if sub1 == sub2 && !seen[sub1] {
				seen[sub1] = true
				count++
			}
		}
	}

	return count
}