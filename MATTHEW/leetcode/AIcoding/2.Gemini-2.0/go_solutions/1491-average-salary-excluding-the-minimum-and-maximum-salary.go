func average(salary []int) float64 {
	minSalary := salary[0]
	maxSalary := salary[0]
	sum := 0

	for _, s := range salary {
		if s < minSalary {
			minSalary = s
		}
		if s > maxSalary {
			maxSalary = s
		}
		sum += s
	}

	sum -= (minSalary + maxSalary)
	return float64(sum) / float64(len(salary)-2)
}