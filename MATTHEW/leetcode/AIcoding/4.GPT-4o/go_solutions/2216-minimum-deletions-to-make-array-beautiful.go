func minDeletions(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    freq := make([]int, 0)
    for _, v := range count {
        freq = append(freq, v)
    }

    sort.Ints(freq)

    deletions := 0
    for i := len(freq) - 2; i >= 0; i-- {
        if freq[i] >= freq[i+1] {
            deletions += freq[i] - freq[i+1] + 1
            freq[i] = freq[i+1] - 1
        }
    }

    return deletions
}