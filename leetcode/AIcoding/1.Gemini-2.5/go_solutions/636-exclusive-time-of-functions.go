package main

import (
	"strconv"
	"strings"
)

func exclusiveTime(n int, logs []string) []int {
	result := make([]int, n)

	// Stack stores [function_id, start_timestamp]
	// Using a slice as a stack
	stack := [][]int{}

	prevTime := 0 // The timestamp of the last processed event (either start or end)

	for _, log := range logs {
		parts := strings.Split(log, ":")
		id, _ := strconv.Atoi(parts[0])
		eventType := parts[1]
		timestamp, _ := strconv.Atoi(parts[2])

		if eventType == "start" {
			if len(stack) > 0 {
				// If there's a function running, it was running until 'timestamp'.
				// Add the time elapsed since prevTime to the currently running function.
				runningFuncID := stack[len(stack)-1][0]
				result[runningFuncID] += timestamp - prevTime
			}
			// Push the new function onto the stack
			stack = append(stack, []int{id, timestamp})
			// Update prevTime to the start time of the new function
			prevTime = timestamp
		} else { // eventType == "end"
			// Pop the function from the stack. The popped function is 'id'.
			stack = stack[:len(stack)-1]

			// Add the time elapsed for this function.
			// It ran from prevTime up to timestamp (inclusive).
			// So, timestamp - prevTime + 1 units of time.
			result[id] += timestamp - prevTime + 1

			// Update prevTime to the time immediately after this function ended
			prevTime = timestamp + 1
		}
	}

	return result
}