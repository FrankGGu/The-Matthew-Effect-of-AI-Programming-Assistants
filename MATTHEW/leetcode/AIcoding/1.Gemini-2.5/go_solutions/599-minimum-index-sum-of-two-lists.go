package main

import "math"

func findRestaurant(list1 []string, list2 []string) []string {
	m := make(map[string]int)
	for i, s := range list1 {
		m[s] = i
	}

	minSum := math.MaxInt32
	var result []string

	for j, s := range list2 {
		if i, ok := m[s]; ok {
			currentSum := i + j
			if currentSum < minSum {
				minSum = currentSum
				result = []string{s}
			} else if currentSum == minSum {
				result = append(result, s)
			}
		}
	}

	return result
}