func getCollisionTimes(cars [][]int) []float64 {
	n := len(cars)
	result := make([]float64, n)
	stack := []int{}

	for i := n - 1; i >= 0; i-- {
		result[i] = -1.0
		for len(stack) > 0 {
			j := stack[len(stack)-1]
			if cars[i][1] <= cars[j][1] {
				stack = stack[:len(stack)-1]
				continue
			}

			time := float64(cars[j][0]-cars[i][0]) / float64(cars[i][1]-cars[j][1])
			if result[j] == -1.0 || time <= result[j] {
				result[i] = time
				break
			} else {
				stack = stack[:len(stack)-1]
			}
		}
		stack = append(stack, i)
	}

	return result
}