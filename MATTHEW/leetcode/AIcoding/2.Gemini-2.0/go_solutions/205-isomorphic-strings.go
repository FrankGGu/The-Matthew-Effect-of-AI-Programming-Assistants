func isIsomorphic(s string, t string) bool {
	if len(s) != len(t) {
		return false
	}

	sMap := make(map[byte]byte)
	tMap := make(map[byte]byte)

	for i := 0; i < len(s); i++ {
		sChar := s[i]
		tChar := t[i]

		if _, ok := sMap[sChar]; !ok {
			if _, ok := tMap[tChar]; !ok {
				sMap[sChar] = tChar
				tMap[tChar] = sChar
			} else {
				return false
			}
		} else {
			if sMap[sChar] != tChar {
				return false
			}
		}
	}

	return true
}