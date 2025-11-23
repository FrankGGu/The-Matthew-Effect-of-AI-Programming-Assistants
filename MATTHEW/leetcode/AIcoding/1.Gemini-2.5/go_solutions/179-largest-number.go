package main

import (
	"sort"
	"strconv"
	"strings"
)

type StringSlice []string

func (s StringSlice) Len() int {
	return len(s)
}

func (s StringSlice) Less(i, j int) bool {
	return s[i]+s[j] > s[j]+s[i]
}

func (s StringSlice) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}

func largestNumber(nums []int) string {
	if len(nums) == 0 {
		return ""
	}

	strNums := make([]string, len(nums))
	for i, num := range nums {
		strNums[i] = strconv.Itoa(num)
	}

	sort.Sort(StringSlice(strNums))

	if strNums[0] == "0" {
		return "0"
	}

	return strings.Join(strNums, "")
}