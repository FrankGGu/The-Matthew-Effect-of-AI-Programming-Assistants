func minOperations(k int) int {
    if k == 1 {
        return 0
    }
    minOps := math.MaxInt32
    for a := 1; a <= k; a++ {
        b := (k + a - 1) / a - 1
        ops := a - 1 + b
        if ops < minOps {
            minOps = ops
        }
        if a > minOps {
            break
        }
    }
    return minOps
}