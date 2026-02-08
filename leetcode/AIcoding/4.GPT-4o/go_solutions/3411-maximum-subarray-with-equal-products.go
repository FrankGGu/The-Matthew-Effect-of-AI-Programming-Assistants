func maxEqualProducts(arr []int) int {
    freq := make(map[int]int)
    for _, num := range arr {
        freq[num]++
    }

    maxCount := 0
    for _, count := range freq {
        if count > maxCount {
            maxCount = count
        }
    }

    return maxCount
}