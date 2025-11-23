func highAccessEmployees(employees [][]int) []int {
    accessCount := make(map[int]int)
    for _, emp := range employees {
        for _, access := range emp[1:] {
            accessCount[access]++
        }
    }

    var result []int
    maxCount := 0
    for _, count := range accessCount {
        if count > maxCount {
            maxCount = count
        }
    }

    for empID, count := range accessCount {
        if count == maxCount {
            result = append(result, empID)
        }
    }

    sort.Ints(result)
    return result
}