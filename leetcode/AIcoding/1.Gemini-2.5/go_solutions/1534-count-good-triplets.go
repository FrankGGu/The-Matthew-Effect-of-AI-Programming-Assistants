package main

import "math"

func countGoodTriplets(arr []int, a int, b int, c int) int {
	n := len(arr)
	count := 0

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			for k := j + 1; k < n; k++ {
				if int(math.Abs(float64(arr[i]-arr[j]))) <= a &&
					int(math.Abs(float64(arr[j]-arr[k]))) <= b &&
					int(math.Abs(float64(arr[i]-arr[k]))) <= c {
					count++
				}
			}
		}
	}

	return count
}