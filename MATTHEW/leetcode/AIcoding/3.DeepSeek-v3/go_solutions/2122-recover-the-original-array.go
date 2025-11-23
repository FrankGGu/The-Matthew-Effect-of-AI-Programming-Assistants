func recoverArray(nums []int) []int {
    sort.Ints(nums)
    n := len(nums)
    for i := 1; i < n; i++ {
        k := nums[i] - nums[0]
        if k == 0 || k % 2 != 0 {
            continue
        }
        k /= 2
        res := []int{}
        used := make([]bool, n)
        left := 0
        for right := 0; right < n; right++ {
            if used[right] {
                continue
            }
            for left < n && (nums[left] < nums[right] - 2*k || used[left]) {
                left++
            }
            if left == n || nums[left] != nums[right] - 2*k {
                break
            }
            used[left] = true
            used[right] = true
            res = append(res, nums[left] + k)
            left++
        }
        if len(res) == n/2 {
            return res
        }
    }
    return nil
}