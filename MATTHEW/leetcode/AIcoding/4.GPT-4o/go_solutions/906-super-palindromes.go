import "math/big"

func superPalindromesInRange(L string, R string) int {
    l, _ := new(big.Int).SetString(L, 10)
    r, _ := new(big.Int).SetString(R, 10)
    count := 0

    for i := 1; i <= 10000; i++ {
        s := strconv.Itoa(i)
        p := s + reverse(s)
        square := new(big.Int).Exp(new(big.Int).SetString(p, 10), big.NewInt(2), nil)
        if square.Cmp(r) > 0 {
            break
        }
        if square.Cmp(l) >= 0 && isPalindrome(square.String()) {
            count++
        }

        p = s + reverse(s[:len(s)-1])
        square = new(big.Int).Exp(new(big.Int).SetString(p, 10), big.NewInt(2), nil)
        if square.Cmp(r) > 0 {
            break
        }
        if square.Cmp(l) >= 0 && isPalindrome(square.String()) {
            count++
        }
    }

    return count
}

func reverse(s string) string {
    b := []rune(s)
    for i, j := 0, len(b)-1; i < j; i, j = i+1, j-1 {
        b[i], b[j] = b[j], b[i]
    }
    return string(b)
}

func isPalindrome(s string) bool {
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        if s[i] != s[j] {
            return false
        }
    }
    return true
}