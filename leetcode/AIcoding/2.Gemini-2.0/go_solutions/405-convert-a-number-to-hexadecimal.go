func toHex(num int) string {
	if num == 0 {
		return "0"
	}

	result := ""
	for i := 0; i < 8 && num != 0; i++ {
		digit := num & 0xF
		if digit < 10 {
			result = string(rune('0'+digit)) + result
		} else {
			result = string(rune('a'+digit-10)) + result
		}
		num >>= 4
	}

	return result
}