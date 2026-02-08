package main

func numDupDigitsIntervals(n int) int {
    var count int
    for i := 1; i <= n; i++ {
        if hasRepeatedDigits(i) {
            count++
        }
    }
    return count
}

func hasRepeatedDigits(x int) bool {
    seen := make(map[int]bool)
    for x > 0 {
        digit := x % 10
        if seen[digit] {
            return true
        }
        seen[digit] = true
        x /= 10
    }
    return false
}