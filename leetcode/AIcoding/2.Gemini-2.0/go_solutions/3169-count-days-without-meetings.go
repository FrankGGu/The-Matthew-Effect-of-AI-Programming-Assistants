func countDaysWithoutMeetings(meetings [][]int, workHours int) int {
	n := len(meetings)
	totalHours := 0
	for i := 0; i < n; i++ {
		totalHours += meetings[i][0]
	}

	ans := 0
	for i := 0; i < 10000; i++ {
		if totalHours <= workHours*7 {
			ans = i + 1
			break
		}
		totalHours -= workHours * 7
	}

	if ans == 0 {
		return -1
	}

	return ans
}