func largeGroupPositions(s string) [][]int {
    result := [][]int{}
    n := len(s)
    if n < 3 {
        return result
    }

    i := 0
    for i < n {
        start := i
        char := s[i]
        j := i
        for j < n && s[j] == char {
            j++
        }

        groupLength := j - start
        if groupLength >= 3 {
            result = append(result, []int{start, j - 1})
        }
        i = j
    }

    return result
}