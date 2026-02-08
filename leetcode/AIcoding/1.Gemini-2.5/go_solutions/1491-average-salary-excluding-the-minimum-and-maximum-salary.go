package main

import "math"

func average(salary []int) float64 {
	minSal := math.MaxInt32
	maxSal := math.MinInt32
	sum := 0

	for _, s := range salary {
		if s < minSal {
			minSal = s
		}
		if s > maxSal {
			maxSal = s
		}
		sum += s
	}

	sum -= minSal
	sum -= maxSal

	return float64(sum) / float64(len(salary)-2)
}