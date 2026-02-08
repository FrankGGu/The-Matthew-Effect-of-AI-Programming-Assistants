func maxDepthAfterSplit(seq string) []int {
    depth := 0
    res := make([]int, len(seq))
    for i, c := range seq {
        if c == '(' {
            depth++
            res[i] = depth % 2
        } else {
            res[i] = depth % 2
            depth--
        }
    }
    return res
}