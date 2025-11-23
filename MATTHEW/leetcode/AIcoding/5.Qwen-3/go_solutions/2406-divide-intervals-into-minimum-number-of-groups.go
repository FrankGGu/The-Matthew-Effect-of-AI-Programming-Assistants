package main

func mergeGroups(intervals [][]int) int {
    if len(intervals) == 0 {
        return 0
    }

    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })

    groups := 0
    endTimes := make([]int, 0)

    for _, interval := range intervals {
        start, end := interval[0], interval[1]
        found := false

        for i := 0; i < len(endTimes); i++ {
            if endTimes[i] < start {
                endTimes[i] = end
                found = true
                break
            }
        }

        if !found {
            endTimes = append(endTimes, end)
            groups++
        }
    }

    return groups
}