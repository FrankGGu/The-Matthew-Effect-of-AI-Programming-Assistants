func minDeletion(nums []int) int {
    n := len(nums)
    count := 0
    i := 0
    for i < n-1 {
        if (i-count)%2 == 0 && nums[i] == nums[i+1] {
            count++
            i++
        } else {
            i += 2
        }
    }
    if (n-count)%2 != 0 {
        count++
    }
    return count
}