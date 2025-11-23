func partitionLabels(S string) []int {
    last := make(map[byte]int)
    for i := range S {
        last[S[i]] = i
    }

    res := []int{}
    start, end := 0, 0
    for i := range S {
        end = max(end, last[S[i]])
        if i == end {
            res = append(res, end-start+1)
            start = i + 1
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}