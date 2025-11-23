func missingRolls(rolls []int, mean int, n int) []int {
    m := len(rolls)
    total := mean * (m + n)
    sumM := 0
    for _, num := range rolls {
        sumM += num
    }
    sumN := total - sumM
    if sumN < n || sumN > 6*n {
        return []int{}
    }
    res := make([]int, n)
    avg := sumN / n
    rem := sumN % n
    for i := 0; i < n; i++ {
        res[i] = avg
        if rem > 0 {
            res[i]++
            rem--
        }
    }
    return res
}