func bestCoordinate(towers [][]int, radius int) []int {
    maxQuality := 0
    res := []int{0, 0}
    for x := 0; x <= 50; x++ {
        for y := 0; y <= 50; y++ {
            quality := 0
            for _, tower := range towers {
                tx, ty, tq := tower[0], tower[1], tower[2]
                d := (x-tx)*(x-tx) + (y-ty)*(y-ty)
                if d <= radius*radius {
                    quality += int(float64(tq) / (1 + math.Sqrt(float64(d))))
                }
            }
            if quality > maxQuality {
                maxQuality = quality
                res = []int{x, y}
            } else if quality == maxQuality {
                if x < res[0] || (x == res[0] && y < res[1]) {
                    res = []int{x, y}
                }
            }
        }
    }
    return res
}