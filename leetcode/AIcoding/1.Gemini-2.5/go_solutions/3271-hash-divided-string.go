func hashDividedString(s string, k int) bool {
	n := len(s)

	if k <= 0 {
		return false
	}

	if n%k != 0 {
		return false
	}

	partLen := n / k

	if partLen == 0 {
		return true
	}

	firstPart := s[0:partLen]

	for i := 1; i < k; i++ {
		currentPart := s[i*partLen : (i+1)*partLen]
		if currentPart != firstPart {
			return false
		}
	}

	return true
}