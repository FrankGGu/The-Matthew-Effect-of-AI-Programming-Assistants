package main

import (
	"strconv"
)

var results []string
var target int
var numStr string

func addOperators(num string, t int) []string {
	results = []string{}
	target = t
	numStr = num

	if len(num) == 0 {
		return results
	}

	for i := 0; i < len(numStr); i++ {
		currentNumStr := numStr[:i+1]
		currentNum, _ := strconv.ParseInt(currentNumStr, 10, 64)

		dfs(i+1, currentNumStr, int(currentNum), int(currentNum))

		if numStr[0] == '0' {
			break
		}
	}

	return results
}

func dfs(index int, path string, currentVal int, lastOperand int) {
	if index == len(numStr) {
		if currentVal == target {
			results = append(results, path)
		}
		return
	}

	for i := index; i < len(numStr); i++ {
		currentNumStr := numStr[index : i+1]
		currentNum, _ := strconv.ParseInt(currentNumStr, 10, 64)

		dfs(i+1, path+"+"+currentNumStr, currentVal+int(currentNum), int(currentNum))

		dfs(i+1, path+"-"+currentNumStr, currentVal-int(currentNum), -int(currentNum))

		dfs(i+1, path+"*"+currentNumStr, currentVal-lastOperand+(lastOperand*int(currentNum)), lastOperand*int(currentNum))

		if numStr[index] == '0' {
			break
		}
	}
}