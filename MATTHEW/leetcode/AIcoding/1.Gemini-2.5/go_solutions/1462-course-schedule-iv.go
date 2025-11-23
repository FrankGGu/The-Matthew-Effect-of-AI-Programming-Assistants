func checkIfPrerequisite(n int, prerequisites [][]int, queries [][]int) []bool {
    isReachable := make([][]bool, n)
    for i := 0; i < n; i++ {
        isReachable[i] = make([]bool, n)
        isReachable[i][i] = true // A course