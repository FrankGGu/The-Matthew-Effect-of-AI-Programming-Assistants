func countHillValley(nums []int) int {
    count := 0
    n := len(nums)
    for i := 1; i < n-1; {
        left := i - 1
        for left >= 0 && nums[left] == nums[i] {
            left--
        }
        if left < 0 {
            i++
            continue
        }
        right := i + 1
        for right < n && nums[right] == nums[i] {
            right++
        }
        if right >= n {
            i++
            continue
        }
        if (nums[left] < nums[i] && nums[right] < nums[i]) || (nums[left] > nums[i] && nums[right] > nums[i]) {
            count++
        }
        i = right
    }
    return count
}