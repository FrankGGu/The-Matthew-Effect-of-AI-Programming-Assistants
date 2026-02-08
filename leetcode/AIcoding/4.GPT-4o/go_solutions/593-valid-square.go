func validSquare(p1 []int, p2 []int, p3 []int, p4 []int) bool {
    points := [][]int{p1, p2, p3, p4}
    distances := make(map[int]int)

    for i := 0; i < 4; i++ {
        for j := i + 1; j < 4; j++ {
            dist := (points[i][0]-points[j][0])*(points[i][0]-points[j][0]) + (points[i][1]-points[j][1])*(points[i][1]-points[j][1])
            distances[dist]++
        }
    }

    if len(distances) != 2 {
        return false
    }

    var side, diagonal int
    for d, count := range distances {
        if count == 4 {
            side = d
        } else if count == 2 {
            diagonal = d
        } else {
            return false
        }
    }

    return side > 0 && diagonal == 2*side
}