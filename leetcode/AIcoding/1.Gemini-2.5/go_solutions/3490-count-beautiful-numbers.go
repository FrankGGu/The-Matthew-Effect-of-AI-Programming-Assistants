package main

import (
	"strconv"
)

var sNum string
var K int
var memo [11][2][2][401][11]int

func initMemo() {
	for i := 0; i < 11; i++ {
		for j := 0; j < 2; j++ {
			for l := 0; l < 2; l++ {
				for m := 0; m < 401; m++ {
					for n := 0; n < 11; n++ {
						memo[i][j][l][m][n] = -1
					}
				}
			}
		}
	}
}

func solve(idx int, tight bool, isStarted bool, currentSumModK int, currentCount int) int {
	if idx == len(sNum) {
		if isStarted && currentSumModK == 0 && currentCount%K == 0 {
			return 1
		}
		return 0
	}

	tightInt := 0
	if tight {
		tightInt = 1
	}
	isStartedInt := 0
	if isStarted {
		isStartedInt = 1
	}

	if memo[idx][tightInt][isStartedInt][currentSumModK][currentCount] != -1 {
		return memo[idx][tightInt][isStartedInt][currentSumModK][currentCount]
	}

	ans := 0
	limit := 9
	if tight {
		limit = int(sNum[idx] - '0')
	}

	for digit := 0; digit <= limit; digit++ {
		if !isStarted && digit == 0 {
			ans += solve(idx+1, tight && (digit == limit), false, 0, 0)
		} else {
			newSumModK := (currentSumModK + digit) % K
			newCount := currentCount + 1
			ans += solve(idx+1, tight && (digit == limit), true, newSumModK, newCount)
		}
	}

	memo[idx][tightInt][isStartedInt][currentSumModK][currentCount] = ans
	return ans
}

func countBeautifulNumbers(num int, k int) int {
	sNum = strconv.Itoa(num)
	K = k
	initMemo()
	return solve(0, true, false, 0, 0)
}