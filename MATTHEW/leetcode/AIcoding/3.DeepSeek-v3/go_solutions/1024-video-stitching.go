func videoStitching(clips [][]int, time int) int {
    maxReach := make([]int, time+1)
    for _, clip := range clips {
        start, end := clip[0], clip[1]
        if start <= time {
            if end > maxReach[start] {
                maxReach[start] = end
            }
        }
    }

    res := 0
    curEnd, nextEnd := 0, 0
    for i := 0; i <= time; i++ {
        if i > nextEnd {
            return -1
        }
        if i > curEnd {
            res++
            curEnd = nextEnd
        }
        if maxReach[i] > nextEnd {
            nextEnd = maxReach[i]
        }
        if nextEnd >= time {
            return res + 1
        }
    }
    return -1
}