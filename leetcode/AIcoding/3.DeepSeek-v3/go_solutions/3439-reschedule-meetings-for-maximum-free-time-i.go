import "sort"

func maxFreeTime(schedule [][]int) int {
    if len(schedule) == 0 {
        return 0
    }

    sort.Slice(schedule, func(i, j int) bool {
        return schedule[i][0] < schedule[j][0]
    })

    maxGap := 0
    prevEnd := schedule[0][1]

    for i := 1; i < len(schedule); i++ {
        currentStart := schedule[i][0]
        if currentStart > prevEnd {
            gap := currentStart - prevEnd
            if gap > maxGap {
                maxGap = gap
            }
        }
        if schedule[i][1] > prevEnd {
            prevEnd = schedule[i][1]
        }
    }

    return maxGap
}