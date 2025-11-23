func findArray(subsetSums []int) []int {
    n := len(subsetSums)
    result := make([]int, 0)
    total := 0

    for _, sum := range subsetSums {
        total ^= sum
    }

    for i := 0; i < n; i++ {
        if subsetSums[i] == total {
            result = append(result, subsetSums[i])
        }
    }

    return result
}