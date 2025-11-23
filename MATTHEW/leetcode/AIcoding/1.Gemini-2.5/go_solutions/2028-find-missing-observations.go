func missingRolls(rolls []int, mean int, n int) []int {
    m := n - len(rolls)

    sumRolls := 0
    for _, r := range rolls {
        sumRolls += r
    }

    targetSum := mean * n
    sumMissing := targetSum - sumRolls

    if sumMissing < m || sumMissing > m * 6 {
        return []int{}
    }

    result := make([]int, m)

    baseVal := sumMissing / m
    remainder := sumMissing % m

    for i := 0; i < m; i++ {
        if i < remainder {
            result[i] = baseVal + 1
        } else {
            result[i] = baseVal
        }
    }

    return result
}