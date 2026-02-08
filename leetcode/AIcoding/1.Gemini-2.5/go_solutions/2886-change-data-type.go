package main

import (
	"strconv"
)

func changeDataType(s string) int {
	num, err := strconv.Atoi(s)
	if err != nil {
		return 0
	}
	return num
}