func checkSubarraySum(nums []int, k int) bool {
    remainderMap := make(map[int]int)
    remainderMap[0] = -1
    sum := 0
    for i, num := range nums {
        sum += num
        remainder := sum % k
        if idx, exists := remainderMap[remainder]; exists {
            if i-idx >= 2 {
                return true
            }
        } else {
            remainderMap[remainder] = i
        }
    }
    return false
}