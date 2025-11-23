func pushDominoes(dominoes string) string {
	n := len(dominoes)
	if n == 0 {
		return ""
	}

	res := []byte(dominoes)

	// Pad the dominoes string to simplify boundary conditions
	// 'L' at the beginning ensures any initial '.' or 'R' is handled
	// 'R' at the end ensures any trailing '.' or 'L' is handled
	s := make([]byte, n+2)
	s[0] = 'L'
	for i := 0; i < n; i++ {
		s[i+1] = dominoes[i]
	}
	s[n+1] = 'R'

	prev := 0 // Index in s of the last 'L' or 'R' encountered

	for i := 1; i < len(s); i++ {
		if s[i] == '.' {
			continue
		}

		// Found a non-'.' character, process the segment s[prev...i]
		leftChar := s[prev]
		rightChar := s[i]

		// Number of '.' dominoes between prev and i
		k := i - prev - 1 

		if leftChar == 'L' && rightChar == 'L' {
			// L...L -> LLLLL
			for j := 0; j < k; j++ {
				res[prev+j] = 'L' // prev+j is the original index of dominoes
			}
		} else if leftChar == 'R' && rightChar == 'R' {
			// R...R -> RRRRR
			for j := 0; j < k; j++ {
				res[prev+j] = 'R' // prev+j is the original index of dominoes
			}
		} else if leftChar == 'R' && rightChar == 'L' {
			// R...L -> RRR.LLL or RR.LL
			// k/2 dominoes fall right, k/2 dominoes fall left
			// If k is odd, the middle one remains upright
			for j := 0; j < k/2; j++ {
				res[prev+j] = 'R'
				res[i-2-j] = 'L' // i-2-j is the original index of dominoes
			}
		}
		// If leftChar == 'L' and rightChar == 'R', the dominoes in between remain '.'
		// (which is their initial state in res, so no action needed)

		prev = i
	}

	return string(res)
}