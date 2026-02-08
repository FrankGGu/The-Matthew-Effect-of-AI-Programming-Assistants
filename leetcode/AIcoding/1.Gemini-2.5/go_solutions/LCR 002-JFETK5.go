func addBinary(a string, b string) string {
	var res strings.Builder
	i := len(a) - 1
	j := len(b) - 1
	carry := 0

	for i >= 0 || j >= 0 || carry > 0 {
		sum := carry
		if i >= 0 {
			sum += int(a[i] - '0')
			i--
		}
		if j >= 0 {
			sum += int(b[j] - '0')
			j--
		}

		res.WriteByte(byte((sum % 2) + '0'))
		carry = sum / 2
	}

	resultStr := res.String()
	runes := []rune(resultStr)
	for k, l := 0, len(runes)-1; k < l; k, l = k+1, l-1 {
		runes[k], runes[l] = runes[l], runes[k]
	}
	return string(runes)
}