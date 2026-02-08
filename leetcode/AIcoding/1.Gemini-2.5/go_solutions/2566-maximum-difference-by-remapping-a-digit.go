package main

import (
	"strconv"
	"strings"
)

func maxDiff(num int) int {
	s := strconv.Itoa(num)

	// Calculate max_num
	maxStr := s
	digitToReplaceForMax := rune(0)
	for _, r := range s {
		if r != '9' {
			digitToReplaceForMax = r
			break
		}
	}
	if digitToReplaceForMax != 0 {
		maxStr = strings.ReplaceAll(s, string(digitToReplaceForMax), "9")
	}
	maxNum, _ := strconv.Atoi(maxStr)

	// Calculate min_num
	minStr := s
	digitToReplaceForMin := rune(0)
	for _, r := range s {
		if r != '0' {
			digitToReplaceForMin = r
			break
		}
	}
	if digitToReplaceForMin != 0 {
		minStr = strings.ReplaceAll(s, string(digitToReplaceForMin), "0")
	}
	minNum, _ := strconv.Atoi(minStr)

	return maxNum - minNum
}