func minDominoRotations(dominoes [][]int) int {
    count := make([][4]int, 7)
    for _, d := range dominoes {
        count[d[0]][0]++
        count[d[1]][1]++
        if d[0] == d[1] {
            count[d[0]][2]++
        }
    }

    for i := 1; i <= 6; i++ {
        total := count[i][0] + count[i][1] - count[i][2]
        if total == len(dominoes) {
            return len(dominoes) - max(count[i][0], count[i][1]) + count[i][2]
        }
    }
    return -1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}