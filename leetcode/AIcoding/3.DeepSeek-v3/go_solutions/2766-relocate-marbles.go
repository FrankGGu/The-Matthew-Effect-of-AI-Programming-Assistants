func relocateMarbles(nums []int, moveFrom []int, moveTo []int) []int {
    marbleSet := make(map[int]bool)
    for _, num := range nums {
        marbleSet[num] = true
    }

    for i := 0; i < len(moveFrom); i++ {
        from := moveFrom[i]
        to := moveTo[i]
        if marbleSet[from] {
            delete(marbleSet, from)
            marbleSet[to] = true
        }
    }

    result := make([]int, 0, len(marbleSet))
    for num := range marbleSet {
        result = append(result, num)
    }
    sort.Ints(result)
    return result
}