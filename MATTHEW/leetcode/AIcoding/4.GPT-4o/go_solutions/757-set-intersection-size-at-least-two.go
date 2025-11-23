func intersectionSizeTwo(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        if intervals[i][1] == intervals[j][1] {
            return intervals[i][0] > intervals[j][0]
        }
        return intervals[i][1] < intervals[j][1]
    })

    points := make([]int, 0)
    count := 0

    for i := 0; i < len(intervals); i++ {
        if len(points) < 2 {
            if len(points) == 0 || points[len(points)-1] < intervals[i][0] {
                points = append(points, intervals[i][1]-1, intervals[i][1])
            } else if points[len(points)-1] == intervals[i][0] {
                points = append(points, intervals[i][1])
            } else {
                points[len(points)-1] = intervals[i][1]
            }
        } else {
            if points[len(points)-1] < intervals[i][0] {
                points = append(points, intervals[i][1]-1, intervals[i][1])
            } else if points[len(points)-1] == intervals[i][0] {
                points[len(points)-1] = intervals[i][1]
            }
        }
    }

    return len(points)
}