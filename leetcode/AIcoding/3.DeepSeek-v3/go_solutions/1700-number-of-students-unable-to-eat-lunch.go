func countStudents(students []int, sandwiches []int) int {
    count := [2]int{}
    for _, s := range students {
        count[s]++
    }
    for _, sw := range sandwiches {
        if count[sw] == 0 {
            break
        }
        count[sw]--
    }
    return count[0] + count[1]
}