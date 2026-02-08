func subarrayBitwiseORs(arr []int) int {
    res := make(map[int]bool)
    curr := make(map[int]bool)

    for _, num := range arr {
        next := make(map[int]bool)
        next[num] = true
        for val := range curr {
            next[val | num] = true
        }
        for val := range next {
            res[val] = true
        }
        curr = next
    }

    return len(res)
}