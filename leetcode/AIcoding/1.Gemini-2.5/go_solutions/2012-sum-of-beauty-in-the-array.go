func sumOfBeauty(nums []int) int {
    n := len(nums)
    if n < 3 {
        return 0
    }

    prefixMax := make([]int, n)
    suffixMin := make([]int, n)

    prefixMax[0] = nums[0]
    for i := 1