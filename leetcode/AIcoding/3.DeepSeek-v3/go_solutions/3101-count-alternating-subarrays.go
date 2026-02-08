func countAlternatingSubarrays(nums []int) int64 {
    var total int64 = 0
    current := 1
    total = 1

    for i := 1; i < len(nums); i++ {
        if nums[i] != nums[i-1] {
            current += 1
        } else {
            current = 1
        }
        total += int64(current)
    }

    return total
}