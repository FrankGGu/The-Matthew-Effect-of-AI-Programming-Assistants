func solve(s string) int64 {
	n := len(s)
	vowels := "aeiou"
	var alice int64
	var bob int64

	for i := 0; i < n; i++ {
		if contains(vowels, s[i]) {
			alice += int64(n - i)
			bob += int64(i + 1)
		}
	}

	if alice > bob {
		return 1
	} else if alice < bob {
		return -1
	} else {
		return 0
	}
}

func contains(s string, char byte) bool {
	for i := 0; i < len(s); i++ {
		if s[i] == char {
			return true
		}
	}
	return false
}