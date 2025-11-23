func getTriggerTime(increase [][]int, requirements [][]int) []int {
	n := len(requirements)
	ans := make([]int, n)
	for i := range ans {
		ans[i] = -1
	}

	c := [3]int{0, 0, 0}
	for i := 0; i <= len(increase); i++ {
		for j := 0; j < n; j++ {
			if ans[j] == -1 && requirements[j][0] <= c[0] && requirements[j][1] <= c[1] && requirements[j][2] <= c[2] {
				ans[j] = i
			}
		}
		if i < len(increase) {
			c[0] += increase[i][0]
			c[1] += increase[i][1]
			c[2] += increase[i][2]
		}
	}
	return ans
}