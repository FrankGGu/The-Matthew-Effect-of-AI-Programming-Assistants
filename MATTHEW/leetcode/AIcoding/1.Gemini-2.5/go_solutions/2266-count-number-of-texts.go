package main

const MOD = 1_000_000_007

var dp3 []int // dp3[k] stores ways to decode k identical 3-option digits
var dp4 []int // dp4[k] stores ways to decode k identical 4-option digits

func init() {
	maxLen := 100000 // Max possible length of pressedKeys
	dp3 = make([]int, maxLen+1)
	dp4 = make([]int, maxLen+1)

	// Precompute dp3 for digits '2', '3', '4', '5', '6', '8' (max 3 presses for a single character)
	// Recurrence: dp3[k] = dp3[k-1] + dp3[k-2] + dp3[k-3]
	dp3[0] = 1 // 1 way to decode an empty sequence
	if maxLen >= 1 {
		dp3[1] = 1 // '2' -> 'a', 'b', 'c'. 1 way to segment (as a single '2')
	}
	if maxLen >= 2 {
		dp3[2] = 2 // '22' -> '2','2' or '22'. 2 ways to segment
	}
	if maxLen >= 3 {
		dp3[3] = 4 // '222' -> '2','2','2' or '2','22' or '22','2' or '222'. 4 ways to segment
	}

	for i := 4; i <= maxLen; i++ {
		dp3[i] = (dp3[i-1] + dp3[i-2]) % MOD
		dp3[i] = (dp3[i] + dp3[i-3]) % MOD
	}

	// Precompute dp4 for digits '7', '9' (max 4 presses for a single character)
	// Recurrence: dp4[k] = dp4[k-1] + dp4[k-2] + dp4[k-3] + dp4[k-4]
	dp4[0] = 1 // 1 way to decode an empty sequence
	if maxLen >= 1 {
		dp4[1] = 1 // '7' -> 'p','q','r','s'. 1 way to segment
	}
	if maxLen >= 2 {
		dp4[2] = 2 // '77' -> '7','7' or '77'. 2 ways to segment
	}
	if maxLen >= 3 {
		dp4[3] = 4 // '777' -> '7','7','7' or '7','77' or '77','7' or '777'. 4 ways to segment
	}
	if maxLen >= 4 {
		dp4[4] = 8 // '7777' -> '7','7','7','7' or '7','7','77' or ... 8 ways to segment
	}

	for i := 5; i <= maxLen; i++ {
		dp4[i] = (dp4[i-1] + dp4[i-2]) % MOD
		dp4[i] = (dp4[i] + dp4[i-3]) % MOD
		dp4[i] = (dp4[i] + dp4[i-4]) % MOD
	}
}

func countTexts(pressedKeys string) int {
	n := len(pressedKeys)
	if n == 0 {
		return 1
	}

	totalWays := 1
	i := 0
	for i < n {
		j := i
		// Find the end of the current block of identical digits
		for j < n && pressedKeys[j] == pressedKeys[i] {
			j++
		}

		// Calculate ways for this block
		length := j - i
		digit := pressedKeys[i]

		var waysForBlock int
		if digit == '7' || digit == '9' {
			waysForBlock = dp4[length]
		} else {
			waysForBlock = dp3[length]
		}

		// Multiply with total ways, taking modulo
		totalWays = (totalWays * waysForBlock) % MOD

		// Move to the next block
		i = j
	}

	return totalWays
}