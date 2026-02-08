func countTriplets(nums []int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            for k := 0; k < n; k++ {
                if (nums[i] & nums[j] & nums[k]) == 0 {
                    count++
                }
            }
        }
    }
    return count
}