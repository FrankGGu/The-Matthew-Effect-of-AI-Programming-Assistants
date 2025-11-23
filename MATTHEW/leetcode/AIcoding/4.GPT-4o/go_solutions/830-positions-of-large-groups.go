func largeGroupPositions(s string) [][]int {
    var result [][]int
    n := len(s)

    for i := 0; i < n; {
        j := i
        for j < n && s[j] == s[i] {
            j++
        }
        if j-i >= 3 {
            result = append(result, []int{i, j-1})
        }
        i = j
    }

    return result
}