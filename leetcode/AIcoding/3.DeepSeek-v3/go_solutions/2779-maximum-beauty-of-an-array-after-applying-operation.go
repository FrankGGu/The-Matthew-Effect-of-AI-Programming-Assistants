func maximumBeauty(nums []int, k int) int {
    sort.Ints(nums)
    max := 0
    left := 0
    for right := 0; right < len(nums); right++ {
        for nums[right]-nums[left] > 2*k {
            left++
        }
        if right-left+1 > max {
            max = right - left + 1
        }
    }
    return max
}