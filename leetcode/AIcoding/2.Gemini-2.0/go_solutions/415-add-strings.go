func addStrings(num1 string, num2 string) string {
	i, j := len(num1)-1, len(num2)-1
	carry := 0
	result := ""
	for i >= 0 || j >= 0 || carry > 0 {
		digit1 := 0
		if i >= 0 {
			digit1 = int(num1[i] - '0')
			i--
		}
		digit2 := 0
		if j >= 0 {
			digit2 = int(num2[j] - '0')
			j--
		}
		sum := digit1 + digit2 + carry
		carry = sum / 10
		digit := sum % 10
		result = string(rune(digit+'0')) + result
	}
	return result
}