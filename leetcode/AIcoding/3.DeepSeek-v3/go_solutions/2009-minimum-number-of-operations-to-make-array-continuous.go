func minOperations(nums []int) int {
    n := len(nums)
    sort.Ints(nums)
    unique := make([]int, 0, n)
    for i := 0; i < n; i++ {
        if i == 0 || nums[i] != nums[i-1] {
            unique = append(unique, nums[i])
        }
    }
    m := len(unique)
    maxInWindow := 0
    left := 0
    for right := 0; right < m; right++ {
        for unique[right]-unique[left] >= n {
            left++
        }
        if right-left+1 > maxInWindow {
            maxInWindow = right - left + 1
        }
    }
    return n - maxInWindow
}