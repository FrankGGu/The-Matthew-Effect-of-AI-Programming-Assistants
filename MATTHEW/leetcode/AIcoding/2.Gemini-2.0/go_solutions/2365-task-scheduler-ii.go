func taskSchedulerII(tasks []int, space int) int64 {
	schedule := make(map[int]int64)
	var day int64 = 0
	for _, task := range tasks {
		lastDay, ok := schedule[task]
		if ok {
			if day <= lastDay+int64(space) {
				day = lastDay + int64(space) + 1
			} else {
				day++
			}
		} else {
			day++
		}
		schedule[task] = day
	}
	return day
}