func findMinFibonacciNumbers(k int) int {
    fibs := []int{1, 1}
    a, b := 1, 1
    for {
        nextFib := a + b
        if nextFib > k {
            break
        }
        fibs = append(fibs, nextFib)
        a = b
        b = nextFib
    }

    count := 0
    for k > 0 {
        for i := len(fibs) - 1; i >= 0; i-- {
            if fibs[i] <= k {
                k -= fibs[i]
                count++
                break
            }
        }
    }
    return count
}