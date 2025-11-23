const mod int = 1e9 + 7

func countSubstrings(s string, t string) int {
	n, m := len(s), len(t)
	ans := 0
	for i := 1; i <= n; i++ {
		for j := 0; j <= n-i; j++ {
			sub := s[j : j+i]
			if canRearrange(sub, t) {
				ans++
			}
		}
	}
	return ans
}

func canRearrange(s string, t string) bool {
	n, m := len(s), len(t)
	if n < m {
		return false
	}
	sCount := make(map[rune]int)
	tCount := make(map[rune]int)

	for _, char := range s {
		sCount[char]++
	}
	for _, char := range t {
		tCount[char]++
	}

	need := 0
	for char, count := range tCount {
		if sCount[char] < count {
			need += count - sCount[char]
		}
	}

	return n-m >= need
}