func maximumBinaryString(binary string) string {
	n := len(binary)
	zeros := 0
	firstZero := -1

	for i := 0; i < n; i++ {
		if binary[i] == '0' {
			zeros++
			if firstZero == -1 {
				firstZero = i
			}
		}
	}

	if zeros <= 1 {
		return binary
	}

	res := make([]byte, n)
	for i := 0; i < n; i++ {
		res[i] = '1'
	}

	res[firstZero+zeros-1] = '0'

	return string(res)
}