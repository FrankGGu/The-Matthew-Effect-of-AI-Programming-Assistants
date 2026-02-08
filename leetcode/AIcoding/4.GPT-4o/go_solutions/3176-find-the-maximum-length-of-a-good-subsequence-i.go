func maximumLengthOfGoodSubsequence(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    maxLength := 0
    for _, freq := range count {
        if freq > 1 {
            maxLength += 2
        } else {
            maxLength++
        }
    }
    return maxLength
}