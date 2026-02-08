func validUtf8(data []int) bool {
	remainingBytes := 0
	for _, byte := range data {
		if remainingBytes == 0 {
			if byte>>7 == 0 {
				continue
			} else if byte>>5 == 6 {
				remainingBytes = 1
			} else if byte>>4 == 14 {
				remainingBytes = 2
			} else if byte>>3 == 30 {
				remainingBytes = 3
			} else {
				return false
			}
		} else {
			if byte>>6 != 2 {
				return false
			}
			remainingBytes--
		}
	}
	return remainingBytes == 0
}