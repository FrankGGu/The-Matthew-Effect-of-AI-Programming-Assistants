package main

func countGroups(ranges [][]int) int {
    sort.Slice(ranges, func(i, j int) bool {
        return ranges[i][0] < ranges[j][0]
    })

    result := 0
    prevEnd := -1

    for _, r := range ranges {
        if r[0] > prevEnd {
            result++
            prevEnd = r[1]
        }
    }

    return result
}