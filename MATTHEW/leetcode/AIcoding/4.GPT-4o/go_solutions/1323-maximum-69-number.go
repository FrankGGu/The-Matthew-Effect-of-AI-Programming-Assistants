func maximum69Number (num int) int {
    strNum := strconv.Itoa(num)
    for i, ch := range strNum {
        if ch == '6' {
            return num + 3 * int(math.Pow(10, float64(len(strNum)-i-1)))
        }
    }
    return num
}