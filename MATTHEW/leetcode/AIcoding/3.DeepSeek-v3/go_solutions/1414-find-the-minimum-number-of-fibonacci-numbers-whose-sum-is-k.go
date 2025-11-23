func findMinFibonacciNumbers(k int) int {
    fibs := []int{1, 1}
    for fibs[len(fibs)-1] < k {
        next := fibs[len(fibs)-1] + fibs[len(fibs)-2]
        fibs = append(fibs, next)
    }

    res := 0
    remaining := k
    for i := len(fibs) - 1; i >= 0 && remaining > 0; i-- {
        if fibs[i] <= remaining {
            remaining -= fibs[i]
            res++
        }
    }
    return res
}