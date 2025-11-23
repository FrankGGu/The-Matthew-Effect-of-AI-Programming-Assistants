func groupThePeople(groupSizes []int) [][]int {
    groups := make(map[int][]int)
    for i, size := range groupSizes {
        groups[size] = append(groups[size], i)
    }

    result := [][]int{}
    for size, members := range groups {
        for i := 0; i < len(members); i += size {
            result = append(result, members[i:i+size])
        }
    }

    return result
}