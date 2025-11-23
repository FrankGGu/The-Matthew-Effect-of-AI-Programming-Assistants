func numOfPairs(nums []string, target string) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if i != j && nums[i]+nums[j] == target {
                count++
            }
        }
    }
    return count
}