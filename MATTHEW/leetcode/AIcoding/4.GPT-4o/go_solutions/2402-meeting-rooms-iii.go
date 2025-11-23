func minMeetingRooms(intervals [][]int) int {
    if len(intervals) == 0 {
        return 0
    }

    starts := make([]int, len(intervals))
    ends := make([]int, len(intervals))

    for i, interval := range intervals {
        starts[i] = interval[0]
        ends[i] = interval[1]
    }

    sort.Ints(starts)
    sort.Ints(ends)

    roomCount := 0
    endPointer := 0

    for i := 0; i < len(intervals); i++ {
        if starts[i] < ends[endPointer] {
            roomCount++
        } else {
            endPointer++
        }
    }

    return roomCount
}