func numTeams(rating []int) int {
	n := len(rating)
	if n < 3 {
		return 0
	}

	count := 0

	for j := 1; j < n-1; j++ {
		leftLess := 0
		leftGreater := 0
		for i := 0; i < j; i++ {
			if rating[i] < rating[j] {
				leftLess++
			} else {
				leftGreater++
			}
		}

		rightLess := 0
		rightGreater := 0
		for k := j + 1; k < n; k++ {
			if rating[k] < rating[j] {
				rightLess++
			} else {
				rightGreater++
			}
		}

		// Teams with increasing ratings: rating[i] < rating[j] < rating[k]
		count += leftLess * rightGreater

		// Teams with decreasing ratings: rating[i] > rating[j] > rating[k]
		count += leftGreater * rightLess
	}

	return count
}