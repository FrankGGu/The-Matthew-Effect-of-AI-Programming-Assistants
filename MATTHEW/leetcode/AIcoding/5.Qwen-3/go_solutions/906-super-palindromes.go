package main

func superPalindromes(l int64, r int64) int {
    var res int
    for i := 1; i <= 100000; i++ {
        s := strconv.Itoa(i)
        for j := 0; j < len(s); j++ {
            s2 := s[:j] + s[j:] + s[:j]
            num, _ := strconv.Atoi(s2)
            if num == 0 {
                continue
            }
            square := int64(num * num)
            if square > r {
                break
            }
            if square >= l && isPalindrome(square) {
                res++
            }
        }
    }
    return res
}

func isPalindrome(x int64) bool {
    s := strconv.Itoa(int(x))
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        if s[i] != s[j] {
            return false
        }
    }
    return true
}