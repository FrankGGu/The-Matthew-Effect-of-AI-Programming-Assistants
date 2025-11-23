package main

import "strings"

func convertToTitle(columnNumber int) string {
	var sb strings.Builder
	for columnNumber > 0 {
		columnNumber--
		remainder := columnNumber % 26
		sb.WriteByte(byte('A' + remainder))
		columnNumber /= 26
	}
	res := sb.String()
	runes := []rune(res)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}