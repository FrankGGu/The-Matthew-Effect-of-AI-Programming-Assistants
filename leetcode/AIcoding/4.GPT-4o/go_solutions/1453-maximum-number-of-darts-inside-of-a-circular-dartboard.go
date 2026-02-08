func numDartsInCircle(r int, darts [][]int) int {
    count := 0
    r2 := r * r
    for _, dart := range darts {
        if dart[0]*dart[0]+dart[1]*dart[1] <= r2 {
            count++
        }
    }
    return count
}