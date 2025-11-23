func lengthOfLIS(nums []int) int {
    if len(nums) == 0 {
        return 0
    }

    dp := make([]int, len(nums))
    length := 0

    for _, num := range nums {
        i := sort.Search(length, func(i int) bool {
            return dp[i] >= num
        })

        dp[i] = num
        if i == length {
            length++
        }
    }

    return length
}