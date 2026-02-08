func sumOfTheDigitsOfHarshadNumber(x int) int {
    sumDigits := 0
    temp := x
    for temp > 0 {
        sumDigits += temp % 10
        temp /= 10
    }

    if x % sumDigits == 0 {
        return sumDigits
    } else {
        return -1
    }
}