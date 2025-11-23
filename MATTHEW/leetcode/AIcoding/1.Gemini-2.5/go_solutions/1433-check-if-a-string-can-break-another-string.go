func checkIfCanBreak(s1 string, s2 string) bool {
	n := len(s1)

	s1Bytes := []byte(s1)
	s2Bytes := []byte(s2)

	sort.Slice(s1Bytes, func(i, j int) bool {
		return s1Bytes[i] < s1Bytes[j]
	})
	sort.Slice(s2Bytes, func(i, j int) bool {
		return s2Bytes[i] < s2Bytes[j]
	})

	canBreakOne := func(b1, b2 []byte) bool {
		for i := 0; i < n; i++ {
			if b1[i] < b2[i] {
				return false
			}
		}
		return true
	}

	return canBreakOne(s1Bytes, s2Bytes) || canBreakOne(s2Bytes, s1Bytes)
}