func recoverArray(n int, sums []int) []int {
    sort.Ints(sums)
    total := sums[0]
    sumsMap := make(map[int]int)
    for _, sum := range sums {
        sumsMap[sum]++
    }

    var result []int
    for i := 1; i < n; i++ {
        if sumsMap[total] > 0 {
            sumsMap[total]--
            result = append(result, total)
            for j := 0; j < len(sums); j++ {
                if sumsMap[sums[j]] > 0 {
                    sumsMap[sums[j]]--
                    total = total - sums[j]
                    break
                }
            }
        }
    }

    return result
}