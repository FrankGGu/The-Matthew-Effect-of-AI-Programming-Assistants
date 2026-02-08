func compress(chars []byte) int {
	n := len(chars)
	if n == 0 {
		return 0
	}

	writeIndex := 0
	count := 1

	for i := 1; i <= n; i++ {
		if i < n && chars[i] == chars[i-1] {
			count++
		} else {
			chars[writeIndex] = chars[i-1]
			writeIndex++
			if count > 1 {
				for _, c := range strconv.Itoa(count) {
					chars[writeIndex] = byte(c)
					writeIndex++
				}
			}
			count = 1
		}
	}
	return writeIndex
}