package main

func largestGoodInteger(s string) string {
    maxNum := ""
    for i := 0; i < len(s)-2; i++ {
        if s[i] == s[i+1] && s[i] == s[i+2] {
            current := s[i : i+3]
            if len(maxNum) == 0 || current > maxNum {
                maxNum = current
            }
        }
    }
    return maxNum
}