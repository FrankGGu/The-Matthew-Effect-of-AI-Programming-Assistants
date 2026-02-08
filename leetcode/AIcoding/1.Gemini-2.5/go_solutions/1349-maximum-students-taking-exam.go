func maxStudents(seats [][]byte) int {
	m := len(seats)
	n := len(seats[0])

	// dp[i][mask] stores the maximum number of students up to row i,
	// with 'mask' representing the seating arrangement