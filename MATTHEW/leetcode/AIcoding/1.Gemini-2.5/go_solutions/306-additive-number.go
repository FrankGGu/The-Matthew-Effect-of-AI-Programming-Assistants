package main

import (
	"math/big"
)

func isAdditiveNumber(num string) bool {
	n := len(num)
	if n < 3 {
		return false
	}

	for i := 1; i < n; i++ {
		num1Str := num[0:i]
		if len(num1Str) > 1 && num1Str[0] == '0' {
			break
		}
		n1, _ := new(big.Int).SetString(num1Str, 10)

		for j := i + 1; j < n; j++ {
			num2Str := num[i:j]
			if len(num2Str) > 1 && num2Str[0] == '0' {
				break
			}
			n2, _ := new(big.Int).SetString(num2Str, 10)

			if checkAdditiveSequence(j, n1, n2, num) {
				return true
			}
		}
	}

	return false
}

func checkAdditiveSequence(idx int, prev1 *big.Int, prev2 *big.Int, num string) bool {
	if idx == len(num) {
		return true
	}

	sum := new(big.Int).Add(prev1, prev2)
	sumStr := sum.String()
	sumLen := len(sumStr)

	if idx+sumLen > len(num) || num[idx:idx+sumLen] != sumStr {
		return false
	}

	return checkAdditiveSequence(idx+sumLen, prev2, sum, num)
}