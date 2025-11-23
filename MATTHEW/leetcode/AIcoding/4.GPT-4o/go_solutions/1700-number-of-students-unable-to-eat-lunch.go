func countStudents(students []int, sandwiches []int) int {
    count := make([]int, 2)
    for _, student := range students {
        count[student]++
    }

    for _, sandwich := range sandwiches {
        if count[sandwich] == 0 {
            break
        }
        count[sandwich]--
    }

    return count[0] + count[1]
}