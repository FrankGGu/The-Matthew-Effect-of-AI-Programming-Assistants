package main

func groupThePeople(groupSizes []int) [][]int {
    groups := make(map[int][]int)
    result := [][]int{}

    for i, size := range groupSizes {
        groups[size] = append(groups[size], i)
        if len(groups[size]) == size {
            result = append(result, groups[size])
            groups[size] = nil
        }
    }

    return result
}