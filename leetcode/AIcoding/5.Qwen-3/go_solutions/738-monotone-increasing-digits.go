package main

func monotoneIncreasingDigits(n int) int {
    s := []byte(strconv.Itoa(n))
    i := 0
    for i < len(s)-1 && s[i] <= s[i+1] {
        i++
    }
    if i == len(s)-1 {
        return n
    }
    for i >= 0 && s[i] > s[i+1] {
        s[i]--
        i--
    }
    for i+1 < len(s) {
        i++
        s[i] = '9'
    }
    res, _ := strconv.Atoi(string(s))
    return res
}