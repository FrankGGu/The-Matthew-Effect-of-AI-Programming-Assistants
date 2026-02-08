func addStrings(num1 string, num2 string) string {
	i := len(num1) - 1
	j := len(num2) - 1
	carry := 0

	res := make([]byte, 0, max(len(num1), len(num2)) + 1) 

	for i >= 0 || j >= 0 || carry > 0 {
		x := 0
		if i >= 0 {
			x = int(num1[i] - '0')
			i--
		}

		y := 0
		if j >= 0 {
			y = int(num2[j] - '0')
			j--
		}

		sum := x + y + carry
		carry = sum / 10
		digit := sum % 10

		res = append(res, byte(digit + '0'))
	}

	for k, l := 0, len(res)-1; k < l; k, l = k+1, l-1 {
		res[k], res[l] = res[l], res[k]
	}

	return string(res)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}