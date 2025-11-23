func countKSizeSubarrays(nums []int, k int) int {
    n := len(nums)
    if n < k {
        return 0
    }
    count := 0
    for i := 0; i <= n-k; i++ {
        prod := 1
        for j := i; j < i+k; j++ {
            prod *= nums[j]
        }
        if prod == k {
            count++
        }
    }
    return count
}