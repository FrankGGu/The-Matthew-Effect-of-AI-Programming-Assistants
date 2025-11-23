package main

import "fmt"

func taskSchedulerII(tasks []int, space int) int64 {
	lastSeen := make(map[int]int64) // taskType -> dayCompleted
	var days int64 = 0

	for _, task := range tasks {
		// Calculate the earliest day this task can be completed.
		// It must be at least one day after the previous task (days + 1).
		earliestCompletionDay := days + 1

		if lastDay, ok := lastSeen[task]; ok {
			// If this task was seen before, calculate its cooldown end day.
			// The task cannot be done on or before cooldownEndDay.
			cooldownEndDay := lastDay + int64(space)

			// If the default earliestCompletionDay (days + 1) falls within the cooldown period,
			// we must wait until the cooldown period is over.
			// The task can then be performed on cooldownEndDay + 1.
			if earliestCompletionDay <= cooldownEndDay {
				earliestCompletionDay = cooldownEndDay + 1
			}
		}

		// Update total days to this earliest completion day.
		days = earliestCompletionDay
		// Record the day this task was completed.
		lastSeen[task] = days
	}

	return days
}