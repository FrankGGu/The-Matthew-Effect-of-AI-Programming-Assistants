package main

func judgeSquareSum(c int) bool {
    max := int(math.Sqrt(float64(c)))
    for a := 0; a <= max; a++ {
        bSquared := c - a*a
        if bSquared < 0 {
            continue
        }
        b := int(math.Sqrt(float64(bSquared)))
        if b*b == bSquared {
            return true
        }
    }
    return false
}