package main

func nextBeautifulNumber(n int) int {
    for {
        n++
        if isBalanced(n) {
            return n
        }
    }
}

func isBalanced(num int) bool {
    count := make(map[int]int)
    for num > 0 {
        digit := num % 10
        count[digit]++
        num /= 10
    }
    for k, v := range count {
        if k != v {
            return false
        }
    }
    return true
}