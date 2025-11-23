package main

import (
	"sort"
)

func maxProfitAssignment(difficulty []int, profit []int, worker []int) int {
	n := len(difficulty)
	jobs := make([][2]int, n)
	for i := 0; i < n; i++ {
		jobs[i] = [2]int{difficulty[i], profit[i]}
	}
	sort.Slice(jobs, func(i, j int) bool {
		return jobs[i][0] < jobs[j][0]
	})
	sort.Ints(worker)

	maxProfit := 0
	currentProfit := 0
	jobIndex := 0

	for _, ability := range worker {
		for jobIndex < n && jobs[jobIndex][0] <= ability {
			if jobs[jobIndex][1] > currentProfit {
				currentProfit = jobs[jobIndex][1]
			}
			jobIndex++
		}
		maxProfit += currentProfit
	}
	return maxProfit
}