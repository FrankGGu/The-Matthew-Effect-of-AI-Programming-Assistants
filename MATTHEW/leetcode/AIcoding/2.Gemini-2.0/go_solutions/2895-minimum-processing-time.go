import "sort"

func minProcessingTime(processorTime []int, tasks []int) int {
	sort.Ints(processorTime)
	sort.Sort(sort.Reverse(sort.IntSlice(tasks)))
	maxTime := 0
	for i := 0; i < len(processorTime); i++ {
		currentTime := processorTime[i] + tasks[i*4]
		if currentTime > maxTime {
			maxTime = currentTime
		}
	}
	return maxTime
}