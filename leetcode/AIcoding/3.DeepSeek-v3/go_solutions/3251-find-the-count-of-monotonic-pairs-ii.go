func countMonotonicPairs(nums []int) int64 {
    n := len(nums)
    if n < 2 {
        return 0
    }
    var count int64
    left := 0
    for right := 1; right < n; right++ {
        if nums[right] >= nums[right-1] {
            length := int64(right - left + 1)
            count += length * (length - 1) / 2
            left = right
        }
    }
    length := int64(n - left)
    count += length * (length - 1) / 2
    left = 0
    for right := 1; right < n; right++ {
        if nums[right] <= nums[right-1] {
            length := int64(right - left + 1)
            count += length * (length - 1) / 2
            left = right
        }
    }
    length = int64(n - left)
    count += length * (length - 1) / 2
    totalPairs := int64(n) * int64(n-1) / 2
    return totalPairs - count
}