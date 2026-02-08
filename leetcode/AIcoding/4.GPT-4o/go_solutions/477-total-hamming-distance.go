func totalHammingDistance(nums []int) int {
    total := 0
    n := len(nums)

    for i := 0; i < 32; i++ {
        count := 0
        for _, num := range nums {
            count += (num >> i) & 1
        }
        total += count * (n - count)
    }

    return total
}