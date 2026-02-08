func minimumSum(nums []int) int {
    n := len(nums)
    ans := int(1e9 + 7)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            for k := j + 1; k < n; k++ {
                if nums[i] < nums[j] && nums[j] > nums[k] {
                    sum := nums[i] + nums[j] + nums[k]
                    if sum < ans {
                        ans = sum
                    }
                }
            }
        }
    }
    if ans == int(1e9 + 7) {
        return -1
    }
    return ans
}