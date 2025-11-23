func primePalindrome(n int) int {
    if n <= 2 {
        return 2
    }
    for {
        if isPalindrome(n) && isPrime(n) {
            return n
        }
        n++
        if 10000000 < n && n < 100000000 {
            n = 100000000
        }
    }
}

func isPrime(x int) bool {
    if x < 2 {
        return false
    }
    for i := 2; i*i <= x; i++ {
        if x%i == 0 {
            return false
        }
    }
    return true
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