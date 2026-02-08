package main

import (
	"regexp"
)

func isNumber(s string) bool {
	re := regexp.MustCompile(`^([+-]?(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?)$`)
	return re.MatchString(s)
}