func maxDepthAfterSplit(seq string) []int {
    depth := 0
    result := make([]int, len(seq))
    for i, char := range seq {
        if char == '(' {
            depth++
            result[i] = depth % 2
        } else {
            result[i] = depth % 2
            depth--
        }
    }
    return result
}