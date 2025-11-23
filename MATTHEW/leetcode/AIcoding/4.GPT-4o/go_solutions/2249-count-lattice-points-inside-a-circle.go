func countLatticePoints(radius int) int {
    count := 0
    r2 := radius * radius
    for x := 0; x <= radius; x++ {
        for y := 0; y <= radius; y++ {
            if x*x+y*y <= r2 {
                count++
            }
        }
    }
    return count * 4 - (radius * radius) - 4 * radius + 1
}