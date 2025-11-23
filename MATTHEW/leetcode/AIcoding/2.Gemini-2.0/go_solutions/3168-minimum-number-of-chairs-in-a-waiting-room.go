import "sort"

func minMeetingRooms(intervals [][]int) int {
    if len(intervals) == 0 {
        return 0
    }

    startTimes := make([]int, len(intervals))
    endTimes := make([]int, len(intervals))

    for i := 0; i < len(intervals); i++ {
        startTimes[i] = intervals[i][0]
        endTimes[i] = intervals[i][1]
    }

    sort.Ints(startTimes)
    sort.Ints(endTimes)

    rooms := 0
    endIdx := 0

    for i := 0; i < len(intervals); i++ {
        if startTimes[i] < endTimes[endIdx] {
            rooms++
        } else {
            endIdx++
        }
    }

    return rooms
}