func checkPowersOfThree(n int) bool {
    for n > 0 {
        remainder := n % 3
        if remainder == 2 {
            return false
        }
        n /= 3
    }
    return true
}