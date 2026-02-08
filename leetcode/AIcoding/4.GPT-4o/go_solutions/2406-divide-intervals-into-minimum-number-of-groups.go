import "sort"

func minGroups(intervals [][]int) int {
    if len(intervals) == 0 {
        return 0
    }
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })

    groups := []int{}

    for _, interval := range intervals {
        start := interval[0]
        end := interval[1]

        var found bool
        for i := 0; i < len(groups); i++ {
            if groups[i] < start {
                groups[i] = end
                found = true
                break
            }
        }

        if !found {
            groups = append(groups, end)
        }
    }

    return len(groups)
}