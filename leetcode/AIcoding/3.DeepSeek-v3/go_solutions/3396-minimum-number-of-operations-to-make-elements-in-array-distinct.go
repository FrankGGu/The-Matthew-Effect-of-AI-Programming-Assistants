func minOperations(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    operations := 0
    for _, count := range freq {
        if count > 1 {
            operations += count - 1
        }
    }

    return operations
}