func maxCompatibilitySum(students [][]int, mentors [][]int) int {
	n := len(students)
	m := len(mentors)
	maxScore := 0

	var permute func([]int, int)
	permute = func(permutation []int, k int) {
		if k == n {
			score := 0
			for i := 0; i < n; i++ {
				for j := 0; j < len(students[i]); j++ {
					if students[i][j] == mentors[permutation[i]][j] {
						score++
					}
				}
			}
			if score > maxScore {
				maxScore = score
			}
			return
		}

		for i := 0; i < m; i++ {
			used := false
			for j := 0; j < k; j++ {
				if permutation[j] == i {
					used = true
					break
				}
			}
			if !used {
				permutation[k] = i
				permute(permutation, k+1)
			}
		}
	}

	permutation := make([]int, n)
	permute(permutation, 0)
	return maxScore
}