func sumOfTheDigitsOfHarshadNumber(x int) int {
    original := x
    if x < 0 {
        x = -x
    }
    sum := 0
    for x > 0 {
        sum += x % 10
        x /= 10
    }
    if sum == 0 {
        return -1
    }
    if original % sum == 0 {
        return sum
    }
    return -1
}