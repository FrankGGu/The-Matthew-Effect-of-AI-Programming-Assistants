func isIsomorphic(s string, t string) bool {
	sToT := make([]byte, 256)
	tToS := make([]byte, 256)

	for i := 0; i < len(s); i++ {
		sChar := s[i]
		tChar := t[i]

		if sToT[sChar] == 0 {
			sToT[sChar] = tChar
		} else if sToT[sChar] != tChar {
			return false
		}

		if tToS[tChar] == 0 {
			tToS[tChar] = sChar
		} else if tToS[tChar] != sChar {
			return false
		}
	}

	return true
}