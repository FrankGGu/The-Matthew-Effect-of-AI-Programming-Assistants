package main

import "strings"

func numberToWords(num int) string {
	if num == 0 {
		return "Zero"
	}
	var result strings.Builder
	if num >= 1000000000 {
		result.WriteString(threeDigits(num / 1000000000) + " Billion")
		num %= 1000000000
	}
	if num >= 1000000 {
		if result.Len() > 0 {
			result.WriteString(" ")
		}
		result.WriteString(threeDigits(num / 1000000) + " Million")
		num %= 1000000
	}
	if num >= 1000 {
		if result.Len() > 0 {
			result.WriteString(" ")
		}
		result.WriteString(threeDigits(num / 1000) + " Thousand")
		num %= 1000
	}
	if num > 0 {
		if result.Len() > 0 {
			result.WriteString(" ")
		}
		result.WriteString(threeDigits(num))
	}
	return result.String()
}

func threeDigits(n int) string {
	if n == 0 {
		return ""
	}
	var result strings.Builder
	hundreds := n / 100
	tens := n % 100
	if hundreds > 0 {
		result.WriteString(oneDigit(hundreds) + " Hundred")
	}
	if tens > 0 {
		if result.Len() > 0 {
			result.WriteString(" ")
		}
		if tens < 20 {
			result.WriteString(oneDigit(tens))
		} else {
			tensDigit := tens / 10
			onesDigit := tens % 10
			result.WriteString(tensDigitStr(tensDigit))
			if onesDigit > 0 {
				result.WriteString(" " + oneDigit(onesDigit))
			}
		}
	}
	return result.String()
}

func oneDigit(n int) string {
	switch n {
	case 1:
		return "One"
	case 2:
		return "Two"
	case 3:
		return "Three"
	case 4:
		return "Four"
	case 5:
		return "Five"
	case 6:
		return "Six"
	case 7:
		return "Seven"
	case 8:
		return "Eight"
	case 9:
		return "Nine"
	case 10:
		return "Ten"
	case 11:
		return "Eleven"
	case 12:
		return "Twelve"
	case 13:
		return "Thirteen"
	case 14:
		return "Fourteen"
	case 15:
		return "Fifteen"
	case 16:
		return "Sixteen"
	case 17:
		return "Seventeen"
	case 18:
		return "Eighteen"
	case 19:
		return "Nineteen"
	default:
		return ""
	}
}

func tensDigitStr(n int) string {
	switch n {
	case 2:
		return "Twenty"
	case 3:
		return "Thirty"
	case 4:
		return "Forty"
	case 5:
		return "Fifty"
	case 6:
		return "Sixty"
	case 7:
		return "Seventy"
	case 8:
		return "Eighty"
	case 9:
		return "Ninety"
	default:
		return ""
	}
}