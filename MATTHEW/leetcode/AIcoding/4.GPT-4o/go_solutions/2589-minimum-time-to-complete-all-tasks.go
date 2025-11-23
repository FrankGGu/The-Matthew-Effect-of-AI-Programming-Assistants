package main

import (
	"sort"
)

func minimumTime(tasks [][]int) int {
	sort.Slice(tasks, func(i, j int) bool {
		return tasks[i][1] < tasks[j][1]
	})

	time := 0
	for _, task := range tasks {
		if time < task[0] {
			time = task[0]
		}
		time += task[1]
	}
	return time
}

func minTimeToComplete(tasks [][]int) int {
	return minimumTime(tasks)
}