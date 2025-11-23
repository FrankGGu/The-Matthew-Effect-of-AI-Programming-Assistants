func maxOperations(nums []int, k int) int {
    count := 0
    freq := make(map[int]int)

    for _, num := range nums {
        freq[num]++
    }

    for num := range freq {
        complement := k - num
        if complement == num {
            count += freq[num] / 2
        } else if freq[complement] > 0 {
            pairs := min(freq[num], freq[complement])
            count += pairs
            freq[num] -= pairs
            freq[complement] -= pairs
        }
    }

    return count
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}