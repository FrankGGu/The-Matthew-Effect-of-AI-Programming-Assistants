func countDays(days int, meetings [][]int) int {
    if len(meetings) == 0 {
        return days
    }

    sort.Slice(meetings, func(i, j int) bool {
        return meetings[i][0] < meetings[j][0]
    })

    merged := [][]int{meetings[0]}
    for i := 1; i < len(meetings); i++ {
        last := merged[len(merged)-1]
        if meetings[i][0] <= last[1] {
            if meetings[i][1] > last[1] {
                last[1] = meetings[i][1]
            }
        } else {
            merged = append(merged, meetings[i])
        }
    }

    total := 0
    for _, interval := range merged {
        total += interval[1] - interval[0] + 1
    }

    return days - total
}