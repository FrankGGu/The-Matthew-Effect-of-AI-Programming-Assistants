func largestVariance(s string) int {
	ans := 0
	freq := make(map[rune]int)
	for _, c := range s {
		freq[c]++
	}

	for ch1 := 'a'; ch1 <= 'z'; ch1++ {
		for ch2 := 'a'; ch2 <= 'z'; ch2++ {
			if ch1 == ch2 || freq[ch1] == 0 || freq[ch2] == 0 {
				continue
			}

			maxVariance := 0
			currVariance := 0
			ch1Exists := false

			for _, c := range s {
				if c == ch1 {
					currVariance++
					ch1Exists = true
				} else if c == ch2 {
					currVariance--
				}

				if currVariance < 0 && ch1Exists {
					currVariance = 0
					ch1Exists = false
				}

				if ch1Exists {
					maxVariance = max(maxVariance, currVariance)
				}

			}

			if !ch1Exists {
				continue
			}

			currVariance = 0
			ch1Exists = false

			for i := len(s) - 1; i >= 0; i-- {
				c := rune(s[i])
				if c == ch1 {
					currVariance++
					ch1Exists = true
				} else if c == ch2 {
					currVariance--
				}

				if currVariance < 0 && ch1Exists {
					currVariance = 0
					ch1Exists = false
				}

				if ch1Exists {
					maxVariance = max(maxVariance, currVariance)
				}
			}

			ans = max(ans, maxVariance)

		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}