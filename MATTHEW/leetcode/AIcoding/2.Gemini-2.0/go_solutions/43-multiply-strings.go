func multiply(num1 string, num2 string) string {
	if num1 == "0" || num2 == "0" {
		return "0"
	}

	m, n := len(num1), len(num2)
	product := make([]int, m+n)

	for i := m - 1; i >= 0; i-- {
		for j := n - 1; j >= 0; j-- {
			digit1 := int(num1[i] - '0')
			digit2 := int(num2[j] - '0')
			p := digit1 * digit2
			p1, p2 := i+j, i+j+1
			sum := product[p2] + p
			product[p2] = sum % 10
			product[p1] += sum / 10
		}
	}

	result := ""
	for _, digit := range product {
		if !(len(result) == 0 && digit == 0) {
			result += string(rune(digit + '0'))
		}
	}

	if len(result) == 0 {
		return "0"
	}
	return result
}