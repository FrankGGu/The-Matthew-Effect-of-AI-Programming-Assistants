func calPoints(ops []string) int {
	stack := []int{}
	sum := 0
	for _, op := range ops {
		switch op {
		case "+":
			top := stack[len(stack)-1]
			secondTop := stack[len(stack)-2]
			newScore := top + secondTop
			stack = append(stack, newScore)
			sum += newScore
		case "D":
			top := stack[len(stack)-1]
			newScore := 2 * top
			stack = append(stack, newScore)
			sum += newScore
		case "C":
			top := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			sum -= top
		default:
			score := 0
			for _, c := range op {
				if c == '-' {
					continue
				}
				score = score*10 + int(c-'0')
			}
			if op[0] == '-' {
				score = -score
			}
			stack = append(stack, score)
			sum += score
		}
	}
	return sum
}