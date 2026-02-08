func minimumEnergy(tasks [][]int) int {
    n := len(tasks)
    minEnergy := 0
    totalEnergy := 0

    for i := 0; i < n; i++ {
        totalEnergy += tasks[i][1]
        if totalEnergy < tasks[i][0] {
            minEnergy += tasks[i][0] - totalEnergy
            totalEnergy = tasks[i][0]
        }
    }

    return minEnergy
}