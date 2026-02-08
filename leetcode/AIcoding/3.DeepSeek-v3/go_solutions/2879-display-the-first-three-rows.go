func firstThreeRows(data [][]int) [][]int {
    if len(data) <= 3 {
        return data
    }
    return data[:3]
}