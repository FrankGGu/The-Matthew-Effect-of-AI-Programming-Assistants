package main

import (
	"strings"
)

var (
	lessThan20 = []string{"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"}
	tens       = []string{"", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"}
	thousands  = []string{"", "Thousand", "Million", "Billion"}
)

func numberToWords(num int) string {
	if num == 0 {
		return "Zero"
	}

	result := []string{}
	level := 0 // 0 for units, 1 for thousands, 2 for millions, 3 for billions

	for num > 0 {
		if num%1000 != 0 {
			part := convertLessThanThousand(num % 1000)
			if level > 0 {
				part += " " + thousands[level]
			}
			result = append([]string{part}, result...) // Prepend the current part
		}
		num /= 1000
		level++
	}

	return strings.Join(result, " ")
}

func convertLessThanThousand(num int) string {
	if num == 0 {
		return ""
	} else if num < 20 {
		return lessThan20[num]
	} else if num < 100 {
		if num%10 == 0 {
			return tens[num/10]
		}
		return tens[num/10] + " " + lessThan20[num%10]
	} else { // num < 1000
		hundredPart := lessThan20[num/100] + " Hundred"
		remainderPart := convertLessThanThousand(num % 100)
		if remainderPart == "" {
			return hundredPart
		}
		return hundredPart + " " + remainderPart
	}
}