package main

func digitCount(n int) bool {
    count := make([]int, 10)
    for n > 0 {
        digit := n % 10
        count[digit]++
        n /= 10
    }
    for i := 0; i < 10; i++ {
        if count[i] != 0 && count[i] != i {
            return false
        }
    }
    return true
}