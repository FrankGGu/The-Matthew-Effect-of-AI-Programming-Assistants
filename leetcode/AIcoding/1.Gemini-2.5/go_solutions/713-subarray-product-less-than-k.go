func numSubarrayProductLessThanK(nums []int, k int) int {
    if k <= 1 {
        return 0
    }

    count := 0
    product := 1
    left := 0

    for right := 0; right < len(nums); right++ {
        product *= nums[right