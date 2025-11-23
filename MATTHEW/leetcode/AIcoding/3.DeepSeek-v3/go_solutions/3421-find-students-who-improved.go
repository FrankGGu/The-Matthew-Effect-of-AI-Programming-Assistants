func findStudents(students [][]int) [][]int {
    improved := make([][]int, 0)
    for _, student := range students {
        id := student[0]
        scores := student[1:]
        improvedFlag := true
        for i := 1; i < len(scores); i++ {
            if scores[i] <= scores[i-1] {
                improvedFlag = false
                break
            }
        }
        if improvedFlag {
            improved = append(improved, []int{id})
        }
    }
    return improved
}