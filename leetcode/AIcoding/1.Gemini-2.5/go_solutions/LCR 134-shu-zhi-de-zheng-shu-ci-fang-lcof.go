func myPow(x float64, n int) float64 {
    // Handle negative exponent
    var N int64 = int64(n)
    if N < 0 {
        x = 1 / x
        N = -N
    }

    // Perform binary exponentiation
    ans := 1.0