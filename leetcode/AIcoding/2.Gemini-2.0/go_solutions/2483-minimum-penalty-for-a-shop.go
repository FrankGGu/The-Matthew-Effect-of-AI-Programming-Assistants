func minPenalty(customers string) int {
	n := len(customers)
	penalty := 0
	for _, c := range customers {
		if c == 'Y' {
			penalty++
		}
	}

	minPenalty := penalty
	minHour := 0

	for i := 0; i < n; i++ {
		if customers[i] == 'Y' {
			penalty--
		} else {
			penalty++
		}

		if penalty < minPenalty {
			minPenalty = penalty
			minHour = i + 1
		}
	}

	return minHour
}