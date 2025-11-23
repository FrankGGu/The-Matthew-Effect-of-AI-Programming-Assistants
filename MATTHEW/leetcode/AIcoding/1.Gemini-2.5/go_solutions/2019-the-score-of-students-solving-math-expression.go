package main

import (
	"strconv"
)

func scoreOfStudents(expression string, answers []int) int {
	nums := []int{}
	ops := []byte{}
	for i := 0; i < len(expression); i++ {
		if expression[i] >= '0' && expression[i] <= '9' {
			num, _ := strconv.Atoi(string(expression[i]))
			nums = append(nums, num)
		} else {
			ops = append(ops, expression[i])
		}
	}

	N := len(nums)

	correctAnswer := calculateCorrectAnswer(nums, ops)

	dp := make([][]map[int]bool, N)
	for i := range dp {
		dp[i] = make([]map[int]bool, N)
		for j := range dp[i] {
			dp[i][j] = make(map[int]bool)
		}
	}

	for i := 0; i < N; i++ {
		if nums[i] <= 1000 {
			dp[i][i][nums[i]] = true
		}
	}

	for length := 2; length <= N; length++ {
		for i := 0; i <= N-length; i++ {
			j := i + length - 1
			for k := i; k < j; k++ {
				op := ops[k]
				for val1 := range dp[i][k] {
					for val2 := range dp[k+1][j] {
						res := 0
						if op == '+' {
							res = val1 + val2
						} else {
							res = val1 * val2
						}
						if res <= 1000 {
							dp[i][j][res] = true
						}
					}
				}
			}
		}
	}

	allPossibleResults := dp[0][N-1]

	score := 0
	for _, ans := range answers {
		if ans == correctAnswer {
			score += 5
		} else if allPossibleResults[ans] {
			score += 2
		}
	}

	return score
}

func calculateCorrectAnswer(nums []int, ops []byte) int {
	tempNums := []int{}
	tempOps := []byte{}

	if len(nums) > 0 {
		tempNums = append(tempNums, nums[0])
	}

	for i := 0; i < len(ops); i++ {
		if ops[i] == '*' {
			lastNum := tempNums[len(tempNums)-1]
			tempNums[len(tempNums)-1] = lastNum * nums[i+1]
		} else {
			tempNums = append(tempNums, nums[i+1])
			tempOps = append(tempOps, ops[i])
		}
	}

	currentSum := 0
	if len(tempNums) > 0 {
		currentSum = tempNums[0]
		for i := 0; i < len(tempOps); i++ {
			currentSum += tempNums[i+1]
		}
	}

	return currentSum
}