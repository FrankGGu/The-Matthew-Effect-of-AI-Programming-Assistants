package main

func getNoZeroIntegers(n int) []int {
    for i := 1; i < n; i++ {
        a, b := i, n-i
        if !hasZero(a) && !hasZero(b) {
            return []int{a, b}
        }
    }
    return []int{}
}

func hasZero(x int) bool {
    for x > 0 {
        if x%10 == 0 {
            return true
        }
        x /= 10
    }
    return false
}