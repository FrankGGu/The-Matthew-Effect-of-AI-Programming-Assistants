package main

func closestDivisors(num int) []int {
    a, b := 0, 0
    minDiff := 1<<31 - 1
    for i := 1; i*i <= num; i++ {
        if num%i == 0 {
            if abs(num/i-i) < minDiff {
                minDiff = abs(num/i - i)
                a, b = i, num/i
            }
        }
    }
    return []int{a, b}
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}