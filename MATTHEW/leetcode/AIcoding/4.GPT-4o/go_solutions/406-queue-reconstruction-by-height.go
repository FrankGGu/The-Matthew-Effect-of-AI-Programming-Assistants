package main

import (
	"sort"
)

func reconstructQueue(people [][]int) [][]int {
	sort.Slice(people, func(i, j int) bool {
		if people[i][0] == people[j][0] {
			return people[i][1] < people[j][1]
		}
		return people[i][0] > people[j][0]
	})

	result := [][]int{}
	for _, person := range people {
		result = append(result[:person[1]], append([][]int{person}, result[person[1]:]...)...)
	}
	return result
}