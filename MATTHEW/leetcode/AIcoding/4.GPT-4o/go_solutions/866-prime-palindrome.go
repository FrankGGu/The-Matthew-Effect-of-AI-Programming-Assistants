func isPalindrome(n int) bool {
    s := strconv.Itoa(n)
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        if s[i] != s[j] {
            return false
        }
    }
    return true
}

func isPrime(n int) bool {
    if n < 2 {
        return false
    }
    for i := 2; i*i <= n; i++ {
        if n%i == 0 {
            return false
        }
    }
    return true
}

func primePalindrome(N int) int {
    if N <= 2 {
        return 2
    }
    for i := 1; i < 1000000; i++ {
        if isPalindrome(i) && isPrime(i) && i >= N {
            return i
        }
    }
    return -1
}