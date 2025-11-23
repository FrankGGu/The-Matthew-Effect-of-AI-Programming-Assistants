func groupThePeople(groupSizes []int) [][]int {
    sizeMap := make(map[int][]int)
    for i, size := range groupSizes {
        sizeMap[size] = append(sizeMap[size], i)
    }

    result := [][]int{}
    for size, indices := range sizeMap {
        for i := 0; i < len(indices); i += size {
            result = append(result, indices[i:i+size])
        }
    }

    return result
}