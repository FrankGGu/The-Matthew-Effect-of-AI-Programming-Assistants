func largestPalindrome(n int) int {
    if n == 1 {
        return 9
    }

    upper := 1
    for i := 0; i < n; i++ {
        upper *= 10
    }
    upper -= 1

    maxPalindrome := 0
    for i := upper; i >= upper/10; i-- {
        for j := i; j >= upper/10; j-- {
            product := i * j
            if product <= maxPalindrome {
                break
            }
            if isPalindrome(product) {
                maxPalindrome = product
            }
        }
    }
    return maxPalindrome % 1337
}

func isPalindrome(num int) bool {
    original := num
    reversed := 0
    for num > 0 {
        reversed = reversed*10 + num%10
        num /= 10
    }
    return original == reversed
}