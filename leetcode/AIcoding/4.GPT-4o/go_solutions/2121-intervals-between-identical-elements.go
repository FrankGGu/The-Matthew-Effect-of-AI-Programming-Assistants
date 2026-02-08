func getDistances(arr []int) []int64 {
    n := len(arr)
    posMap := make(map[int][]int)

    for i, num := range arr {
        posMap[num] = append(posMap[num], i)
    }

    result := make([]int64, n)

    for _, positions := range posMap {
        total, count := int64(0), int64(len(positions))
        for i, pos := range positions {
            total += int64(pos) * (count - int64(i)) - int64(pos) * int64(i)
        }
        for _, pos := range positions {
            result[pos] = total
        }
    }

    return result
}