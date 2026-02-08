func isStrictlyPalindromic(n int) bool {
    for base := 2; base <= n-2; base++ {
        if !isPalindromic(n, base) {
            return false
        }
    }
    return true
}

func isPalindromic(n, base int) bool {
    digits := []int{}
    for n > 0 {
        digits = append(digits, n%base)
        n /= base
    }
    for i := 0; i < len(digits)/2; i++ {
        if digits[i] != digits[len(digits)-1-i] {
            return false
        }
    }
    return true
}