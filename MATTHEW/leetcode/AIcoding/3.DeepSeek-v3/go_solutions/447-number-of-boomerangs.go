func numberOfBoomerangs(points [][]int) int {
    res := 0
    for i := 0; i < len(points); i++ {
        distMap := make(map[int]int)
        for j := 0; j < len(points); j++ {
            if i == j {
                continue
            }
            dx := points[i][0] - points[j][0]
            dy := points[i][1] - points[j][1]
            dist := dx*dx + dy*dy
            distMap[dist]++
        }
        for _, v := range distMap {
            res += v * (v - 1)
        }
    }
    return res
}