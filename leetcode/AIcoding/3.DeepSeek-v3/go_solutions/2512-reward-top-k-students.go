import (
	"sort"
	"strings"
)

func topStudents(positive_feedback []string, negative_feedback []string, report []string, student_id []int, k int) []int {
	pos := make(map[string]bool)
	neg := make(map[string]bool)
	for _, word := range positive_feedback {
		pos[word] = true
	}
	for _, word := range negative_feedback {
		neg[word] = true
	}

	type student struct {
		id    int
		score int
	}
	students := make([]student, len(report))
	for i, r := range report {
		words := strings.Fields(r)
		score := 0
		for _, word := range words {
			if pos[word] {
				score += 3
			} else if neg[word] {
				score -= 1
			}
		}
		students[i] = student{student_id[i], score}
	}

	sort.Slice(students, func(i, j int) bool {
		if students[i].score == students[j].score {
			return students[i].id < students[j].id
		}
		return students[i].score > students[j].score
	})

	res := make([]int, k)
	for i := 0; i < k; i++ {
		res[i] = students[i].id
	}
	return res
}