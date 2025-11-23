func findThePrefixCommonArray(A []int, B []int) []int {
    n := len(A)
    C := make([]int, n)
    count := 0
    freq := make(map[int]int)

    for i := 0; i < n; i++ {
        freq[A[i]]++
        if freq[A[i]] == 2 {
            count++
        }
        freq[B[i]]++
        if freq[B[i]] == 2 {
            count++
        }
        C[i] = count
    }

    return C
}