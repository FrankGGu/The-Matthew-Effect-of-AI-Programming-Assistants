func subarrayBitwiseORs(A []int) int {
    res := make(map[int]struct{})
    curr := make(map[int]struct{})
    for _, num := range A {
        next := make(map[int]struct{})
        next[num] = struct{}{}
        for k := range curr {
            next[k|num] = struct{}{}
        }
        curr = next
        for k := range curr {
            res[k] = struct{}{}
        }
    }
    return len(res)
}