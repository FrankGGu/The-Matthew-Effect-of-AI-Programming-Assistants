package main

func longestObstacleCourseAtEachPosition(obstacles []int) []int {
    n := len(obstacles)
    res := make([]int, n)
    tails := []int{}

    for i := 0; i < n; i++ {
        idx := sort.Search(len(tails), func(j int) bool {
            return tails[j] >= obstacles[i]
        })
        if idx == len(tails) {
            tails = append(tails, obstacles[i])
        } else {
            tails[idx] = obstacles[i]
        }
        res[i] = idx + 1
    }

    return res
}