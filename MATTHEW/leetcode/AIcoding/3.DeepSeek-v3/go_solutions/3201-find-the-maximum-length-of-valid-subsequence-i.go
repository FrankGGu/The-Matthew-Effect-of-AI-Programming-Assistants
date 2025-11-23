func maximumLength(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    maxLen := 0
    for num := range freq {
        current := num
        length := 0
        for {
            if cnt, exists := freq[current]; exists && cnt >= 1 {
                length++
                if current % 2 != 0 {
                    break
                }
                current /= 2
            } else {
                break
            }
        }
        if length > maxLen {
            maxLen = length
        }
    }
    return maxLen
}