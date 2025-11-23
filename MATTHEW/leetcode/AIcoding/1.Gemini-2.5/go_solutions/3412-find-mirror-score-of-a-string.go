func findMirrorScore(s string) int {
	mirrorChars := map[rune]bool{
		'A': true, 'H': true, 'I': true, 'M': true, 'O': true,
		'T': true, 'U': true, 'V': true, 'W': true, '		X': true, 'Y': true,
		'0': true, '1': true, '8': true,
	}

	score := 0
	for _, char := range s {
		if mirrorChars[char] {
			score++
		}
	}
	return score
}