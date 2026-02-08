func longestTask(employees [][]int) int {
    longest, employeeID := 0, -1

    for _, emp := range employees {
        totalTime := 0
        for _, time := range emp[1:] {
            totalTime += time
        }
        if totalTime > longest {
            longest = totalTime
            employeeID = emp[0]
        }
    }

    return employeeID
}