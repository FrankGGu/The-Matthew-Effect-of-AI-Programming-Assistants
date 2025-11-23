package main

import (
	"sort"
)

func minProcessingTime(processorTime []int, tasks []int) int {
	sort.Ints(processorTime)
	sort.Ints(tasks)

	maxOverallTime := 0
	numProcessors := len(processorTime)
	numTasks := len(tasks)

	for i := 0; i < numProcessors; i++ {
		// processorTime[i] is the i-th fastest processor.
		// To minimize the maximum processing time, the fastest processors should handle the slowest tasks,
		// and the slowest processors should handle the fastest tasks.
		//
		// Since processorTime is sorted ascending (fastest to slowest processor),
		// processorTime[0] (fastest) should be paired with the 4 slowest tasks.
		// processorTime[1] (second fastest) should be paired with the next 4 slowest tasks, and so on.
		//
		// tasks is sorted ascending (fastest to slowest task).
		// The slowest 4 tasks are at indices: numTasks-4, numTasks-3, numTasks-2, numTasks-1.
		// The next 4 slowest tasks are at indices: numTasks-8, numTasks-7, numTasks-6, numTasks-5.
		//
		// For processorTime[i]:
		// It will be paired with tasks starting from index `numTasks - 4*(i+1)` up to `numTasks - 4*i - 1`.
		// The latest task it finishes will be `tasks[numTasks - 4*i - 1]`.
		//
		// Example:
		// i=0 (fastest processor): tasks[numTasks-1], tasks[numTasks-2], tasks[numTasks-3], tasks[numTasks-4].
		//   Latest task index: numTasks - 4*0 - 1 = numTasks - 1.
		// i=1 (second fastest): tasks[numTasks-5], tasks[numTasks-6], tasks[numTasks-7], tasks[numTasks-8].
		//   Latest task index: numTasks - 4*1 - 1 = numTasks - 5.
		// This pattern matches.

		currentProcessorFinishTime := processorTime[i] + tasks[numTasks-1-(4*i)]
		if currentProcessorFinishTime > maxOverallTime {
			maxOverallTime = currentProcessorFinishTime
		}
	}

	return maxOverallTime
}