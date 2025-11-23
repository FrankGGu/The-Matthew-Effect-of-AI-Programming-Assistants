func findStudents(students [][]int) [][]int {
    var result [][]int
    for _, student := range students {
        if student[1] > student[0] {
            result = append(result, student)
        }
    }
    return result
}