func findThePrefixCommonArray(A []int, B []int) []int {
    n := len(A)
    result := make([]int, n)
    countA, countB := make(map[int]int), make(map[int]int)

    for i := 0; i < n; i++ {
        countA[A[i]]++
        countB[B[i]]++
        common := 0
        for k := range countA {
            if countA[k] > 0 && countB[k] > 0 {
                common++
            }
        }
        result[i] = common
    }
    return result
}