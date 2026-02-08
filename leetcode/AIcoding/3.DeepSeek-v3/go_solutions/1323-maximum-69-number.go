func maximum69Number (num int) int {
    s := strconv.Itoa(num)
    maxNum := num
    for i := 0; i < len(s); i++ {
        if s[i] == '6' {
            newS := s[:i] + "9" + s[i+1:]
            newNum, _ := strconv.Atoi(newS)
            if newNum > maxNum {
                maxNum = newNum
            }
            break
        }
    }
    return maxNum
}