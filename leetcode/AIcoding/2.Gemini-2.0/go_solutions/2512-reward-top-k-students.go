import "sort"

func topStudents(positive_feedback []string, negative_feedback []string, report []string, student_id []int, k int) []int {
	positive := make(map[string]bool)
	for _, w := range positive_feedback {
		positive[w] = true
	}
	negative := make(map[string]bool)
	for _, w := range negative_feedback {
		negative[w] = true
	}

	scores := make([]int, len(student_id))
	for i, r := range report {
		words := strings.Split(r, " ")
		score := 0
		for _, w := range words {
			if positive[w] {
				score += 3
			} else if negative[w] {
				score -= 1
			}
		}
		scores[i] = score
	}

	type student struct {
		id    int
		score int
	}

	students := make([]student, len(student_id))
	for i := range student_id {
		students[i] = student{id: student_id[i], score: scores[i]}
	}

	sort.Slice(students, func(i, j int) bool {
		if students[i].score == students[j].score {
			return students[i].id < students[j].id
		}
		return students[i].score > students[j].score
	})

	result := make([]int, 0, k)
	for i := 0; i < k && i < len(students); i++ {
		result = append(result, students[i].id)
	}

	return result
}