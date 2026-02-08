func countKSubarrays(arr []int, k int) int {
    count := 0
    sum := 0
    freq := make(map[int]int)
    freq[0] = 1

    for i := 0; i < len(arr); i++ {
        sum += arr[i]
        if _, ok := freq[sum-k]; ok {
            count += freq[sum-k]
        }
        freq[sum]++
    }

    return count
}