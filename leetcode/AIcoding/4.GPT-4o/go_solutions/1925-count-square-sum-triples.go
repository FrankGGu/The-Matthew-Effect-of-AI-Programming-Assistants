func countTriplets(n int) int {
    count := 0
    for a := 1; a*a <= n; a++ {
        for b := a; a*a+b*b <= n; b++ {
            c2 := a*a + b*b
            c := int(math.Sqrt(float64(c2)))
            if c*c == c2 && c <= n {
                count++
            }
        }
    }
    return count
}