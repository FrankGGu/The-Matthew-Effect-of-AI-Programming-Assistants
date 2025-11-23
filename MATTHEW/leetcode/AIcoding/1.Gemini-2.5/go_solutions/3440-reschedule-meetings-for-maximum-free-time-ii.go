func maxFreeTime(meetings [][]int, k int) int {
	n := len(meetings)
	if n == 0 {
		return 0 // No meetings, so no occupied time, thus no free time if total span is 0. If span is given, it would be that