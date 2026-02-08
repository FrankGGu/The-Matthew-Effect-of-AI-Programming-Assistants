package main

import (
	"strings"
)

func maxRepeating(sequence string, word string) int {
	ans := 0
	temp := word
	for strings.Contains(sequence, temp) {
		ans++
		temp += word
	}
	return ans
}