func relocateMarbles(marbles []int, moveFrom []int, moveTo []int) []int {
    pos := make(map[int]int)
    for _, m := range marbles {
        pos[m]++
    }
    for i := 0; i < len(moveFrom); i++ {
        if count, exists := pos[moveFrom[i]]; exists {
            pos[moveTo[i]] += count
            delete(pos, moveFrom[i])
        }
    }
    result := make([]int, 0, len(pos))
    for k := range pos {
        result = append(result, k)
    }
    sort.Ints(result)
    return result
}