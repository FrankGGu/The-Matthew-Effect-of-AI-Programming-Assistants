package main

func groupThePeople(people []int) [][]int {
    groups := make(map[int][]int)
    result := [][]int{}

    for i, size := range people {
        if len(groups[size]) == size {
            result = append(result, groups[size])
            groups[size] = []int{i}
        } else {
            groups[size] = append(groups[size], i)
        }
    }

    for _, group := range groups {
        result = append(result, group)
    }

    return result
}