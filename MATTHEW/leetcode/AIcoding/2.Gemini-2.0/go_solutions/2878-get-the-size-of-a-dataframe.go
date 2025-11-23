func dataFrameSize(df [][]int) []int {
	rows := len(df)
	cols := 0
	if rows > 0 {
		cols = len(df[0])
	}
	return []int{rows, cols}
}