func superpalindromesInRange(left string, right string) int {
    L, _ := new(big.Int).SetString(left, 10)
    R, _ := new(big.Int).SetString(right, 10)
    count := 0

    isPalindrome := func(s string) bool {
        for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
            if s[i] != s[j] {
                return false
            }
        }
        return true
    }

    for k := 1; k < 100000; k++ {
        s := strconv.Itoa(k)
        t := s
        for i := len(s) - 2; i >= 0; i-- {
            t += string(s[i])
        }
        n, _ := new(big.Int).SetString(t, 10)
        n.Mul(n, n)
        if n.Cmp(R) > 0 {
            break
        }
        if n.Cmp(L) >= 0 && isPalindrome(n.String()) {
            count++
        }
    }

    for k := 1; k < 100000; k++ {
        s := strconv.Itoa(k)
        t := s
        for i := len(s) - 1; i >= 0; i-- {
            t += string(s[i])
        }
        n, _ := new(big.Int).SetString(t, 10)
        n.Mul(n, n)
        if n.Cmp(R) > 0 {
            break
        }
        if n.Cmp(L) >= 0 && isPalindrome(n.String()) {
            count++
        }
    }

    return count
}