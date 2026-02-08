package main

func areNumbersAscending(s string) bool {
    prev := 0
    for i := 0; i < len(s); i++ {
        if s[i] >= '0' && s[i] <= '9' {
            num := 0
            for i < len(s) && s[i] >= '0' && s[i] <= '9' {
                num = num*10 + int(s[i]-'0')
                i++
            }
            if num <= prev {
                return false
            }
            prev = num
        }
    }
    return true
}