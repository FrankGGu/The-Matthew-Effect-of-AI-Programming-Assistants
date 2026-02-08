func uniqueLetterString(s string) int {
    index := make(map[rune][]int)
    for i, c := range s {
        index[c] = append(index[c], i)
    }
    res := 0
    for _, indices := range index {
        for i := 0; i < len(indices); i++ {
            left := 0
            if i > 0 {
                left = indices[i-1] + 1
            }
            right := len(s) - 1
            if i < len(indices)-1 {
                right = indices[i+1] - 1
            }
            res += (indices[i] - left + 1) * (right - indices[i] + 1)
        }
    }
    return res
}