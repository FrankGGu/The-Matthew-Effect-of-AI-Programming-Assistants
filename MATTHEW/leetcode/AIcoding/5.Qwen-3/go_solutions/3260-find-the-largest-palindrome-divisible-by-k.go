package main

func largestPalindrome(n int, k int) int {
    if k == 1 {
        return 9
    }
    max := 0
    for i := 100; i <= 999; i++ {
        for j := i; j <= 999; j++ {
            product := i * j
            if product > max && isPalindrome(product) && product%k == 0 {
                max = product
            }
        }
    }
    return max
}

func isPalindrome(x int) bool {
    if x < 0 {
        return false
    }
    original := x
    reversed := 0
    for x > 0 {
        reversed = reversed*10 + x%10
        x /= 10
    }
    return original == reversed
}