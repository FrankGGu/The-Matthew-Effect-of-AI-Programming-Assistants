import "sort"

func topKStudents(score []int, k int) []int {
    type student struct {
        index int
        score int
    }

    students := make([]student, len(score))
    for i := 0; i < len(score); i++ {
        students[i] = student{i, score[i]}
    }

    sort.Slice(students, func(i, j int) bool {
        if students[i].score == students[j].score {
            return students[i].index < students[j].index
        }
        return students[i].score > students[j].score
    })

    result := make([]int, k)
    for i := 0; i < k; i++ {
        result[i] = students[i].index
    }

    return result
}