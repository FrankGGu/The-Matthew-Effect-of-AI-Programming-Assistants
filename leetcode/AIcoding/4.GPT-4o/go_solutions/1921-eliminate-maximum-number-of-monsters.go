package main

import (
	"sort"
)

func eliminateMaximum(dist []int, speed []int) int {
	n := len(dist)
	time := make([]float64, n)
	for i := 0; i < n; i++ {
		time[i] = float64(dist[i]) / float64(speed[i])
	}
	sort.Float64s(time)
	for i := 0; i < n; i++ {
		if float64(i) >= time[i] {
			return i
		}
	}
	return n
}

func main() {
	// You can test the function here with different inputs
}