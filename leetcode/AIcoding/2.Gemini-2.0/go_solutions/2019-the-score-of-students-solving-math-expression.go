func scoreOfStudents(s string, answers []int) int {
	n := len(s)
	nums := []int{}
	ops := []byte{}
	num := 0
	for i := 0; i < n; i++ {
		if s[i] >= '0' && s[i] <= '9' {
			num = num*10 + int(s[i]-'0')
		} else {
			nums = append(nums, num)
			num = 0
			ops = append(ops, s[i])
		}
	}
	nums = append(nums, num)

	correct := calculate(nums, ops)

	dp := make([][][]bool, n/2+1)
	for i := 0; i <= n/2; i++ {
		dp[i] = make([][]bool, n/2+1)
		for j := 0; j <= n/2; j++ {
			dp[i][j] = make([]bool, 201)
		}
	}

	for i := 0; i <= n/2; i++ {
		dp[i][i][nums[i]] = true
	}

	for length := 2; length <= n/2+1; length++ {
		for i := 0; i <= n/2-length+1; i++ {
			j := i + length - 1
			for k := i; k < j; k++ {
				op := ops[k]
				for x := 0; x <= 200; x++ {
					for y := 0; y <= 200; y++ {
						if dp[i][k][x] && dp[k+1][j][y] {
							val := 0
							if op == '+' {
								val = x + y
							} else {
								val = x * y
							}
							if val >= 0 && val <= 200 {
								dp[i][j][val] = true
							}
						}
					}
				}
			}
		}
	}

	score := 0
	studentAnswers := make(map[int]bool)
	for _, ans := range answers {
		studentAnswers[ans] = true
	}

	for ans := 0; ans <= 200; ans++ {
		if dp[0][n/2][ans] {
			if ans == correct && studentAnswers[ans] {
				score += 5
			} else if ans != correct && studentAnswers[ans] {
				score += 2
			}
		}
	}

	return score
}

func calculate(nums []int, ops []byte) int {
	stack := []int{}
	stack = append(stack, nums[0])
	for i := 0; i < len(ops); i++ {
		if ops[i] == '+' {
			stack = append(stack, nums[i+1])
		} else {
			top := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			stack = append(stack, top*nums[i+1])
		}
	}

	sum := 0
	for _, num := range stack {
		sum += num
	}
	return sum
}