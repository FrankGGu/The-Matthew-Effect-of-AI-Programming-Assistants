func reverse(x int) int {
    sign := 1
    if x < 0 {
        sign = -1
        x = -x
    }
    reversed := 0
    for x != 0 {
        digit := x % 10
        x /= 10
        if reversed > (1<<31-1)/10 || (reversed == (1<<31-1)/10 && digit > 7) {
            return 0
        }
        reversed = reversed*10 + digit
    }
    return sign * reversed
}