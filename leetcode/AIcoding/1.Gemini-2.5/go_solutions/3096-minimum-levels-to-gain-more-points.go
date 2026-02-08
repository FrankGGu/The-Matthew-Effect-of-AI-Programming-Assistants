package main

func minimumLevels(possible []int) int {
	n := len(possible)
	var totalSum int64
	for _, score := range possible {
		totalSum += int64(score)
	}

	var currentOurScore int64
	for k := 1; k <= n; k++ {
		currentOurScore += int64(possible[k-1])
		if 2*currentOurScore > totalSum {
			return k
		}
	}
	return -1
}