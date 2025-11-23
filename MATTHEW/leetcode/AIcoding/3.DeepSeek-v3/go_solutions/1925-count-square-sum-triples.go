func countTriples(n int) int {
    count := 0
    for a := 1; a <= n; a++ {
        for b := 1; b <= n; b++ {
            cSquared := a*a + b*b
            c := int(math.Sqrt(float64(cSquared)))
            if c*c == cSquared && c <= n {
                count++
            }
        }
    }
    return count
}