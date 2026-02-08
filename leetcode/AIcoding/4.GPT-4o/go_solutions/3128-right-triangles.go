func countRightTriangles(n int) int {
    count := 0
    for a := 1; a <= n; a++ {
        for b := a; b <= n; b++ {
            c2 := a*a + b*b
            c := int(math.Sqrt(float64(c2)))
            if c*c == c2 && c <= n {
                if a == b {
                    count++
                } else {
                    count += 2
                }
            }
        }
    }
    return count
}