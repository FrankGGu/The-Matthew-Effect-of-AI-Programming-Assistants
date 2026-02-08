package main

func myPow(x float64, n int) float64 {
    if n == 0 {
        return 1
    }
    if n < 0 {
        x = 1 / x
        n = -n
    }
    return myPow(x, n/2) * myPow(x, n/2) * (func() float64 {
        if n%2 == 1 {
            return x
        }
        return 1
    })()
}