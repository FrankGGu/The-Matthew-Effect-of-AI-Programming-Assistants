func canBeEqual(s string, target string) bool {
	countOnesS := 0
	for _, char := range s {
		if char == '1' {
			countOnesS++
		}
	}

	countOnesT := 0
	for _, char := range target {
		if char == '1' {
			countOnesT++
		}
	}

	return (countOnesS > 0) == (countOnesT > 0)
}