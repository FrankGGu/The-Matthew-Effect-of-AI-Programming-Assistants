func findPairs(nums []int, k int) int {
    if k < 0 {
        return 0
    }

    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    count := 0
    for num := range freq {
        if k == 0 {
            if freq[num] > 1 {
                count++
            }
        } else {
            if _, exists := freq[num + k]; exists {
                count++
            }
        }
    }

    return count
}