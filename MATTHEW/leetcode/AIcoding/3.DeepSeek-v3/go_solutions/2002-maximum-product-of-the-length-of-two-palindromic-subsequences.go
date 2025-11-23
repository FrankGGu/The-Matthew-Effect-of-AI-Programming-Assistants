func maxProduct(s string) int {
    n := len(s)
    maxProd := 0
    palindromes := make(map[int]int)

    for mask := 1; mask < (1 << n); mask++ {
        subseq := make([]byte, 0)
        for i := 0; i < n; i++ {
            if mask&(1<<i) != 0 {
                subseq = append(subseq, s[i])
            }
        }
        if isPalindrome(subseq) {
            palindromes[mask] = len(subseq)
        }
    }

    for mask1, len1 := range palindromes {
        for mask2, len2 := range palindromes {
            if mask1&mask2 == 0 {
                if len1*len2 > maxProd {
                    maxProd = len1 * len2
                }
            }
        }
    }

    return maxProd
}

func isPalindrome(s []byte) bool {
    left, right := 0, len(s)-1
    for left < right {
        if s[left] != s[right] {
            return false
        }
        left++
        right--
    }
    return true
}