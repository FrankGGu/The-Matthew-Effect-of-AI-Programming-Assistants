func groupThePeople(groupSizes []int) [][]int {
    sizeMap := make(map[int][]int)
    var result [][]int

    for i, size := range groupSizes {
        sizeMap[size] = append(sizeMap[size], i)
        if len(sizeMap[size]) == size {
            result = append(result, sizeMap[size])
            sizeMap[size] = []int{}
        }
    }

    return result
}