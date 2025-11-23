func numberOfBoomerangs(points [][]int) int {
    count := 0
    for _, p1 := range points {
        distCount := make(map[int]int)
        for _, p2 := range points {
            if p1 != p2 {
                dist := (p1[0]-p2[0])*(p1[0]-p2[0]) + (p1[1]-p2[1])*(p1[1]-p2[1])
                distCount[dist]++
            }
        }
        for _, c := range distCount {
            count += c * (c - 1)
        }
    }
    return count
}