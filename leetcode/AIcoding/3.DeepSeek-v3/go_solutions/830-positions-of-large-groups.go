func largeGroupPositions(s string) [][]int {
    var result [][]int
    n := len(s)
    if n < 3 {
        return result
    }
    start := 0
    for i := 1; i < n; i++ {
        if s[i] != s[start] {
            if i - start >= 3 {
                result = append(result, []int{start, i-1})
            }
            start = i
        }
    }
    if n - start >= 3 {
        result = append(result, []int{start, n-1})
    }
    return result
}