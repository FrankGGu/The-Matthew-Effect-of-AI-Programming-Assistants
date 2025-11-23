func canBeEqual(target []int, arr []int) bool {
    counts := make([]int, 1001) // Max value is 1000

    for _, num := range target {
        counts[num]++
    }

    for _, num := range arr {
        counts[num]--
    }

    for _, count := range counts {
        if count != 0 {
            return false
        }
    }

    return true
}