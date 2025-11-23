func smallestMissingValueAfterOperations(nums []int, value int) int {
    counts := make([]int, value)
    for _, num := range nums {
        remainder := num % value
        counts[remainder]++
    }

    for k := 0; k < value; k++ {
        if counts[k] == 0 {
            return k
        }
    }

    return value
}