func canWinning(num int) bool {
    if num <= 0 {
        return false
    }
    return num%11 == 0
}