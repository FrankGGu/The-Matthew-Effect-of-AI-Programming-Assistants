func toHex(num int) string {
	if num == 0 {
		return "0"
	}

	hexChars := "0123456789abcdef"
	result := ""

	// Use unsigned 32-bit integer for correct two's complement handling,
	// especially for negative numbers, as Go's right shift on unsigned
	// integers is logical (fills with 0).
	uNum := uint32(num)

	for uNum > 0 {
		// Get the last 4 bits
		val := uNum & 0xF
		// Prepend the corresponding hex character
		result = string(hexChars[val]) + result
		// Shift right by 4 bits
		uNum >>= 4
	}

	return result
}