package main

import "math"

func leastInterval(tasks []byte, n int) int {
	freq := make([]int, 26)
	for _, task := range tasks {
		freq[task-'A']++
	}

	maxFreq := 0
	for _, f := range freq {
		if f > maxFreq {
			maxFreq = f
		}
	}

	tasksWithMaxFreq := 0
	for _, f := range freq {
		if f == maxFreq {
			tasksWithMaxFreq++
		}
	}

	// Calculate the minimum time based on the most frequent tasks
	// (maxFreq - 1) * (n + 1) accounts for the slots needed to separate maxFreq-1 occurrences of the most frequent task.
	// tasksWithMaxFreq accounts for the last occurrences of all tasks that have maxFreq.
	minTime := (maxFreq-1)*(n+1) + tasksWithMaxFreq

	// The total time must be at least the total number of tasks
	return int(math.Max(float64(minTime), float64(len(tasks))))
}