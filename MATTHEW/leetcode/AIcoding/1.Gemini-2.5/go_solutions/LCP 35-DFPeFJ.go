func findChampion(n int, grid [][]int) int {
    beatenByCount := make([]int, n)

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                beatenByCount[j]++
            }
        }
    }

    championCandidate := -1
    candidateCount := 0

    for i := 0; i < n; i++ {
        if beatenByCount[i] == 0 {
            championCandidate = i
            candidateCount++
        }
    }

    if candidateCount == 1 {
        return championCandidate
    }
    return -1
}