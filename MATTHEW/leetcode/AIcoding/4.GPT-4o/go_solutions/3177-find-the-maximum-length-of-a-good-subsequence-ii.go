func maximumLengthOfGoodSubsequence(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    count := 0
    for _, v := range freq {
        if v > 1 {
            count += v
        } else {
            count++
        }
    }

    return count
}