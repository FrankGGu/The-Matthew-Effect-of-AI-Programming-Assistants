func countServers(servers [][]int) int {
    rowCount := make([]int, len(servers))
    colCount := make([]int, len(servers[0]))

    for i := 0; i < len(servers); i++ {
        for j := 0; j < len(servers[0]); j++ {
            if servers[i][j] == 1 {
                rowCount[i]++
                colCount[j]++
            }
        }
    }

    count := 0
    for i := 0; i < len(servers); i++ {
        for j := 0; j < len(servers[0]); j++ {
            if servers[i][j] == 1 && (rowCount[i] > 1 || colCount[j] > 1) {
                count++
            }
        }
    }

    return count
}