package main

func minWindow(s string, t string) string {
	if len(s) < len(t) || len(t) == 0 {
		return ""
	}

	from := make(map[byte]int)
	for i := 0; i < len(t); i++ {
		from[t[i]]++
	}

	required := len(from)
	window := make(map[byte]int)
	formed := 0
	left, right := 0, 0
	minLength := math.MaxInt32
	resultStart, resultEnd := 0, 0

	for right < len(s) {
		char := s[right]
		window[char]++

		if window[char] == from[char] {
			formed++
		}

		for formed == required {
			if right-left+1 < minLength {
				minLength = right - left + 1
				resultStart = left
				resultEnd = right
			}

			leftChar := s[left]
			window[leftChar]--
			if window[leftChar] < from[leftChar] {
				formed--
			}
			left++
		}

		right++
	}

	if minLength == math.MaxInt32 {
		return ""
	}

	return s[resultStart:resultEnd+1]
}