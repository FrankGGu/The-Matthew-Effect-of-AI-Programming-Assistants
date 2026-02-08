func brokenCalc(X int, Y int) int {
    if X >= Y {
        return X - Y
    }
    steps := 0
    for Y > X {
        if Y % 2 == 0 {
            Y /= 2
        } else {
            Y++
        }
        steps++
    }
    return steps + (X - Y)
}