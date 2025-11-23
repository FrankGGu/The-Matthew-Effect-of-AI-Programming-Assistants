func containsNearbyDuplicate(nums []int, k int) bool {
    seen := make(map[int]int)
    for i, num := range nums {
        if pos, exists := seen[num]; exists && i - pos <= k {
            return true
        }
        seen[num] = i
    }
    return false
}