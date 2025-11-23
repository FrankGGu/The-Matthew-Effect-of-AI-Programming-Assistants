func countWays(nums []int) int {
    sort.Ints(nums)
    ways := 0
    n := len(nums)

    if nums[0] > 0 {
        ways++
    }

    for i := 0; i < n-1; i++ {
        if nums[i] < i+1 && nums[i+1] > i+1 {
            ways++
        }
    }

    if nums[n-1] < n {
        ways++
    }

    return ways
}