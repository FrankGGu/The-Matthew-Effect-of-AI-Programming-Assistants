package main

func bestCoordinate(target int, stations []int) []int {
    n := len(stations)
    maxQuality := 0
    result := []int{0, 0}
    for x := 0; x < 100; x++ {
        for y := 0; y < 100; y++ {
            quality := 0
            for i := 0; i < n; i += 3 {
                dx := x - stations[i]
                dy := y - stations[i+1]
                dist := dx*dx + dy*dy
                if dist <= stations[i+2]*stations[i+2] {
                    quality += stations[i+2] - int(math.Sqrt(float64(dist)))
                }
            }
            if quality > maxQuality {
                maxQuality = quality
                result = []int{x, y}
            } else if quality == maxQuality && (x < result[0] || (x == result[0] && y < result[1])) {
                result = []int{x, y}
            }
        }
    }
    return result
}