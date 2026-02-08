func largestPalindrome(K int) int {
    if K == 1 {
        return 9876543210123456789 % 1000000007
    }
    upper := 1
    for i := 0; i < K; i++ {
        upper *= 10
    }
    upper--
    for i := upper; i >= upper/10; i-- {
        palindrome := createPalindrome(i)
        for j := upper; j*j >= palindrome; j-- {
            if palindrome%j == 0 && palindrome/j < upper {
                return palindrome % 1000000007
            }
        }
    }
    return 0
}

func createPalindrome(num int) int {
    palindrome := num
    for num > 0 {
        palindrome = palindrome*10 + num%10
        num /= 10
    }
    return palindrome
}