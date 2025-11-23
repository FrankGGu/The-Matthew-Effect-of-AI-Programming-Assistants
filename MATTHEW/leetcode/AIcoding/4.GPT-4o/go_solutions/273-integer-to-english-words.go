package main

import (
	"strings"
)

func numberToWords(num int) string {
	if num == 0 {
		return "Zero"
	}

	billions := num / 1_000_000_000
	millions := (num / 1_000_000) % 1_000
	thousands := (num / 1_000) % 1_000
	hundreds := num % 1_000

	var parts []string

	if billions > 0 {
		parts = append(parts, convert(billions)+" Billion")
	}
	if millions > 0 {
		parts = append(parts, convert(millions)+" Million")
	}
	if thousands > 0 {
		parts = append(parts, convert(thousands)+" Thousand")
	}
	if hundreds > 0 {
		parts = append(parts, convert(hundreds))
	}

	return strings.Join(parts, " ")
}

func convert(num int) string {
	if num == 0 {
		return ""
	}

	lessThan20 := []string{"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"}
	tens := []string{"", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"}

	if num < 20 {
		return lessThan20[num]
	} else if num < 100 {
		return tens[num/10] + " " + convert(num%10)
	} else {
		return lessThan20[num/100] + " Hundred " + convert(num%100)
	}
}