package main

func countTriples(n int) int {
    count := 0
    for a := 1; a <= n; a++ {
        for b := 1; b <= n; b++ {
            cSquare := a*a + b*b
            c := int(math.Sqrt(float64(cSquare)))
            if c*c == cSquare && c <= n {
                count++
            }
        }
    }
    return count
}