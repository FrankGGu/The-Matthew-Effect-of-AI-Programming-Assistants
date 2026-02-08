package main

func minAddToMakeIntegerBeautiful(n int64, target int) int64 {
    if n >= target {
        return 0
    }
    var power int64 = 1
    for {
        next := (n / power + 1) * power
        if next >= target {
            return next - n
        }
        power *= 10
    }
}