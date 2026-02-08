func countKDifference(nums []int, k int) int {
    count := 0
    freq := make(map[int]int)

    for _, num := range nums {
        count += freq[num - k] + freq[num + k]
        freq[num]++
    }

    return count
}