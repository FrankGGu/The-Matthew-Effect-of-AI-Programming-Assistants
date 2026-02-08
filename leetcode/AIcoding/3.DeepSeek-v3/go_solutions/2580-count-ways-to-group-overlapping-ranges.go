func countWays(ranges [][]int) int {
    sort.Slice(ranges, func(i, j int) bool {
        return ranges[i][0] < ranges[j][0]
    })

    groups := 1
    end := ranges[0][1]

    for i := 1; i < len(ranges); i++ {
        if ranges[i][0] > end {
            groups++
            end = ranges[i][1]
        } else {
            if ranges[i][1] > end {
                end = ranges[i][1]
            }
        }
    }

    res := 1
    for i := 0; i < groups; i++ {
        res = (res * 2) % 1000000007
    }

    return res
}