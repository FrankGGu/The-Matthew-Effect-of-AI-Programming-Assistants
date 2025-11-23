package main

import (
	"strconv"
)

var memo [11][2][2][11][11][21]int // idx, tight, isLeadingZero, evenCount, oddCount, modK
var S string
var K int

func numberOfBeautifulIntegers(low int, high int, k int) int {
	K = k
	highStr := strconv.Itoa(high)
	lowStr := strconv.Itoa(low - 1)

	ansHigh := solve(highStr)
	ansLow := solve(lowStr)

	return ansHigh - ansLow
}

func solve(numStr string) int {
	S = numStr
	for i := range memo {
		for j := range memo[i] {
			for l := range memo[i][j] {
				for m := range memo[i][j][l] {
					for n := range memo[i][j][l][m] {
						for o := range memo[i][j][l][m][n] {
							memo[i][j][l][m][n][o] = -1
						}
					}
				}
			}
		}
	}
	return dfs(0, true, true, 0, 0, 0)
}

func dfs(idx int, tight bool, isLeadingZero bool, evenCount int, oddCount int, modK int) int {
	if idx == len(S) {
		if evenCount == oddCount && evenCount > 0 && modK == 0 {
			return 1
		}
		return 0
	}

	tightInt := 0
	if tight {
		tightInt = 1
	}
	isLeadingZeroInt := 0
	if isLeadingZero {
		isLeadingZeroInt = 1
	}

	if memo[idx][tightInt][isLeadingZeroInt][evenCount][oddCount][modK] != -1 {
		return memo[idx][tightInt][isLeadingZeroInt][evenCount][oddCount][modK]
	}

	ans := 0
	upperBound := 9
	if tight {
		upperBound = int(S[idx] - '0')
	}

	for digit := 0; digit <= upperBound; digit++ {
		if isLeadingZero && digit == 0 {
			ans += dfs(idx+1, tight && (digit == upperBound), true, 0, 0, 0)
		} else {
			newEvenCount := evenCount
			newOddCount := oddCount
			if digit%2 == 0 {
				newEvenCount++
			} else {
				newOddCount++
			}
			newModK := (modK*10 + digit) % K
			ans += dfs(idx+1, tight && (digit == upperBound), false, newEvenCount, newOddCount, newModK)
		}
	}

	memo[idx][tightInt][isLeadingZeroInt][evenCount][oddCount][modK] = ans
	return ans
}