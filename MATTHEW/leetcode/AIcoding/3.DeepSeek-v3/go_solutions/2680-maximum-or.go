func maximumOr(nums []int, k int) int64 {
    n := len(nums)
    prefix := make([]int, n+1)
    suffix := make([]int, n+1)

    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] | nums[i]
    }

    for i := n - 1; i >= 0; i-- {
        suffix[i] = suffix[i+1] | nums[i]
    }

    maxOr := int64(0)
    for i := 0; i < n; i++ {
        current := int64(nums[i]) << k
        total := prefix[i] | int(current) | suffix[i+1]
        if int64(total) > maxOr {
            maxOr = int64(total)
        }
    }

    return maxOr
}