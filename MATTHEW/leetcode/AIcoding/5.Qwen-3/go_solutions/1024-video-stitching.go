package main

func videoStitching(clips [][]int, T int) int {
    sort.Slice(clips, func(i, j int) bool {
        if clips[i][0] == clips[j][0] {
            return clips[i][1] < clips[j][1]
        }
        return clips[i][0] < clips[j][0]
    })

    res := 0
    i := 0
    n := len(clips)
    currEnd := 0
    nextEnd := 0

    for i < n && currEnd < T {
        if clips[i][0] > currEnd {
            return -1
        }
        for i < n && clips[i][0] <= currEnd {
            nextEnd = max(nextEnd, clips[i][1])
            i++
        }
        res++
        currEnd = nextEnd
        if currEnd >= T {
            return res
        }
    }

    return -1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}