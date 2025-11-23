func shiftingLetters(s string, shifts [][]int) string {
	n := len(s)
	diff := make([]int, n+1)

	for _, shift := range shifts {
		start := shift[0]
		end := shift[1]
		direction := shift[2]

		if direction == 1 {
			diff[start]++
			diff[end+1]--
		} else {
			diff[start]--
			diff[end+1]++
		}
	}

	result := []rune(s)
	curr := 0
	for i := 0; i < n; i++ {
		curr += diff[i]
		shift := curr % 26
		if shift < 0 {
			shift += 26
		}

		newChar := rune(int(s[i]-'a'+byte(shift))%26 + 'a')
		result[i] = newChar
	}

	return string(result)
}