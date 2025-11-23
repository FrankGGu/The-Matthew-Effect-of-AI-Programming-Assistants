package main

func kMirror(k, n int) int {
    var res int
    var count int
    for i := 1; count < n; i++ {
        s := strconv.Itoa(i)
        if isPalindrome(s) {
            if isKMirror(k, i) {
                count++
                res = i
            }
        }
    }
    return res
}

func isPalindrome(s string) bool {
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        if s[i] != s[j] {
            return false
        }
    }
    return true
}

func isKMirror(k, num int) bool {
    s := ""
    for num > 0 {
        s = strconv.Itoa(num%k) + s
        num /= k
    }
    return isPalindrome(s)
}