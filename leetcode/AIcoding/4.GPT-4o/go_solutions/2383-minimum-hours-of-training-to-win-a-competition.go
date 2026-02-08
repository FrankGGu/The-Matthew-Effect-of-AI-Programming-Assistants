func minHours(neededTime []int, overtime []int) int {
    n := len(neededTime)
    totalHours := 0
    for i := 0; i < n; i++ {
        if neededTime[i] > overtime[i] {
            totalHours += neededTime[i] - overtime[i]
        }
    }
    return totalHours
}