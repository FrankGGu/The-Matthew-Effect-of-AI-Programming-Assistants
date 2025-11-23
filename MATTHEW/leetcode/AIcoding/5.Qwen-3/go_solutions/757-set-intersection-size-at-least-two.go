package main

func intersectionSizeOne(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        if intervals[i][1] == intervals[j][1] {
            return intervals[i][0] > intervals[j][0]
        }
        return intervals[i][1] < intervals[j][1]
    })

    res := 0
    last := -1
    secondLast := -1

    for _, interval := range intervals {
        if interval[0] > secondLast {
            res += 2
            secondLast = interval[1]
            last = interval[1]
        } else if interval[0] > last {
            res += 1
            secondLast = last
            last = interval[1]
        }
    }

    return res
}