package main

import (
	"strconv"
	"strings"
)

func complexNumberMultiply(num1 string, num2 string) string {
	real1, imag1 := parseComplex(num1)
	real2, imag2 := parseComplex(num2)

	resultReal := (real1 * real2) - (imag1 * imag2)
	resultImag := (real1 * imag2) + (imag1 * real2)

	return strconv.Itoa(resultReal) + "+" + strconv.Itoa(resultImag) + "i"
}

func parseComplex(s string) (int, int) {
	plusIndex := strings.IndexByte(s, '+')
	realPartStr := s[:plusIndex]
	imagPartStr := s[plusIndex+1 : len(s)-1] // Exclude 'i'

	realPart, _ := strconv.Atoi(realPartStr)
	imagPart, _ := strconv.Atoi(imagPartStr)

	return realPart, imagPart
}