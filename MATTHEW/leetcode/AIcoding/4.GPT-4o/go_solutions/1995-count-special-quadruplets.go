func countQuadruplets(nums []int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n-3; i++ {
        for j := i + 1; j < n-2; j++ {
            for k := j + 1; k < n-1; k++ {
                for l := k + 1; l < n; l++ {
                    if nums[i]+nums[j]+nums[k] == nums[l] {
                        count++
                    }
                }
            }
        }
    }
    return count
}