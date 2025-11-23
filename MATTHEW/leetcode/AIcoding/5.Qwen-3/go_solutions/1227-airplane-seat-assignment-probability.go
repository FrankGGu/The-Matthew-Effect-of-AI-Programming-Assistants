package main

func nthPersonGetsNthSeat(n int) float64 {
    if n == 1 {
        return 1.0
    }
    return 1.0 / float64(n)
}