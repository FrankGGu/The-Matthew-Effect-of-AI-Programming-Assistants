package main

func countLargestGroup(n int) int {
    count := make([]int, 20)
    for i := 1; i <= n; i++ {
        sum := 0
        num := i
        for num > 0 {
            sum += num % 10
            num /= 10
        }
        count[sum]++
    }
    maxSize := 0
    result := 0
    for _, c := range count {
        if c > maxSize {
            maxSize = c
            result = 1
        } else if c == maxSize {
            result++
        }
    }
    return result
}