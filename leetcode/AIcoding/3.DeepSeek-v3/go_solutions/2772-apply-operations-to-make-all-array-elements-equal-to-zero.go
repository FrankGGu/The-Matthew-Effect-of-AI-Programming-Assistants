func checkArray(nums []int, k int) bool {
    n := len(nums)
    diff := make([]int, n+1)
    current := 0

    for i := 0; i < n; i++ {
        current += diff[i]
        nums[i] += current

        if nums[i] == 0 {
            continue
        }

        if nums[i] < 0 || i + k > n {
            return false
        }

        current -= nums[i]
        if i + k < n {
            diff[i + k] += nums[i]
        }
    }

    return true
}