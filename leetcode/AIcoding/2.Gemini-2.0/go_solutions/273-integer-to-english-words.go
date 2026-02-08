func numberToWords(num int) string {
	lessThan20 := []string{"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"}
	tens := []string{"", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"}
	thousands := []string{"", "Thousand", "Million", "Billion"}

	if num == 0 {
		return "Zero"
	}

	var helper func(num int) string
	helper = func(num int) string {
		if num < 20 {
			return lessThan20[num]
		} else if num < 100 {
			return tens[num/10] + " " + lessThan20[num%10]
		} else {
			return lessThan20[num/100] + " Hundred " + helper(num%100)
		}
	}

	result := ""
	for i := 0; num > 0; i++ {
		if num%1000 != 0 {
			result = helper(num%1000) + " " + thousands[i] + " " + result
		}
		num /= 1000
	}

	result = strings.TrimSpace(result)
	return result
}