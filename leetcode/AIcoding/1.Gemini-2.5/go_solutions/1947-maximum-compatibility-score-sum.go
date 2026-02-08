func maxCompatibilitySum(students [][]int, mentors [][]int) int {
	m := len(students)
	n := len(students[0])

	// Precompute compatibility scores for all student-mentor pairs
	// compatScores[i][j] will store the compatibility between student i and mentor j
	compatScores := make([][]int, m)
	for i := 0; i < m; i++ {
		compatScores[i] = make([]int, m)
		for j := 0; j < m; j++ {
			score := 0
			for k := 0; k < n; k++ {
				if students[i][k] == mentors[j][k] {
					score++
				}
			}
			compatScores[i][j] = score
		}
	}

	// Memoization table: memo[studentIdx][usedMentorsMask]
	// Stores the maximum compatibility sum for students from studentIdx onwards,
	// given that mentors represented by usedMentorsMask have already been assigned.
	// Initialize with -1 to indicate uncomputed states.
	memo := make([][]int, m)
	for i := 0; i < m; i++ {
		memo[i] = make([]int, 1<<(m))
		for j := 0; j < (1 << m); j++