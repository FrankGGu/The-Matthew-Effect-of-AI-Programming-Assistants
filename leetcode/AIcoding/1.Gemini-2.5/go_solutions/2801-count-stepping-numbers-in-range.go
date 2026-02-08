package main

import (
	"strconv"
)

const MOD = 1e9 + 7

var dp [101][11][2][2]int // idx, prevDigit, isLeadingZero, isTight
var numStr string

func solve(idx int, prevDigit int, isLeadingZero bool, isTight bool) int {
	if idx == len(numStr) {
		return 1
	}

	memoKey := dp[idx][prevDigit][boolToInt(isLeadingZero)][boolToInt(isTight)]
	if memoKey != -1 {
		return memoKey
	}

	ans := 0
	upperBound := 9
	if isTight {
		upperBound = int(numStr[idx] - '0')
	}

	for digit := 0; digit <= upperBound; digit++ {
		if isLeadingZero {
			if digit == 0 { // Still placing leading zeros
				ans = (ans + solve(idx+1, prevDigit, true, isTight && (digit == upperBound))) % MOD
			} else { // First non-zero digit
				ans = (ans + solve(idx+1, digit, false, isTight && (digit == upperBound))) % MOD
			}
		} else { // Not leading zeros, must satisfy stepping number condition
			if abs(digit-prevDigit) == 1 {
				ans = (ans + solve(idx+1, digit, false, isTight && (digit == upperBound))) % MOD
			}
		}
	}

	dp[idx][prevDigit][boolToInt(isLeadingZero)][boolToInt(isTight)] = ans
	return ans
}

func boolToInt(b bool) int {
	if b {
		return 1
	}
	return 0
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func resetDP() {
	for i := 0; i < 101; i++ {
		for j := 0; j < 11; j++ {
			for k := 0; k < 2; k++ {
				for l := 0; l < 2; l++ {
					dp[i][j][k][l] = -1
				}
			}
		}
	}
}

func countSteppingNumbersUpTo(s string) int {
	numStr = s
	resetDP()
	return solve(0, 10, true, true)
}

func decrementString(s string) string {
	n := len(s)
	chars := []byte(s)
	i := n - 1
	for i >= 0 {
		if chars[i] == '0' {
			chars[i] = '9'
			i--
		} else {
			chars[i]--
			break
		}
	}

	if len(chars) > 1 && chars[0] == '0' {
		firstNonZero := 0
		for firstNonZero < len(chars)-1 && chars[firstNonZero] == '0' {
			firstNonZero++
		}
		return string(chars[firstNonZero:])
	}
	return string(chars)
}

func countSteppingNumbers(low string, high string) int {
	ansHigh := countSteppingNumbersUpTo(high)

	ansLowMinus1 := 0
	if low != "0" {
		lowMinus1 := decrementString(low)
		ansLowMinus1 = countSteppingNumbersUpTo(lowMinus1)
	}

	result := (ansHigh - ansLowMinus1 + MOD) % MOD
	return result
}