func maxSumDivThree(nums []int) int {
    dp := [3]int{0, -1, -1}
    for _, num := range nums {
        current := dp
        for i := 0; i < 3; i++ {
            if current[i] != -1 {
                sum := current[i] + num
                mod := sum % 3
                if dp[mod] < sum {
                    dp[mod] = sum
                }
            }
        }
    }
    return dp[0]
}