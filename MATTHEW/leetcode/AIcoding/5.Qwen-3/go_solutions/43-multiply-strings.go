package main

func multiply(num1 string, num2 string) string {
	if num1 == "0" || num2 == "0" {
		return "0"
	}

	result := make([]int, len(num1)+len(num2))

	for i := len(num1) - 1; i >= 0; i-- {
		for j := len(num2) - 1; j >= 0; j-- {
			mul := int(num1[i]-'0') * int(num2[j]-'0')
			pos1 := i + j
			pos2 := i + j + 1
			sum := result[pos2] + mul
			result[pos2] = sum % 10
			result[pos1] += sum / 10
		}
	}

	// Convert result to string
	var sb []byte
	for _, v := range result {
		if !(len(sb) == 0 && v == 0) {
			sb = append(sb, byte(v+'0'))
		}
	}

	if len(sb) == 0 {
		return "0"
	}

	return string(sb)
}