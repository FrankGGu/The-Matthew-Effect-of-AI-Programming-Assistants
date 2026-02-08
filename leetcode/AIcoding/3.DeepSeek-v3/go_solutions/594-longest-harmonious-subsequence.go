func findLHS(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    maxLen := 0
    for num, count := range freq {
        if freq[num+1] > 0 {
            if count + freq[num+1] > maxLen {
                maxLen = count + freq[num+1]
            }
        }
    }
    return maxLen
}