func numOfUniqueSubjects(teachers [][]string) []int {
    result := make([]int, len(teachers))
    for i, subjects := range teachers {
        uniqueSubjects := make(map[string]struct{})
        for _, subject := range subjects {
            uniqueSubjects[subject] = struct{}{}
        }
        result[i] = len(uniqueSubjects)
    }
    return result
}