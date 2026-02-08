func containsNearbyDuplicate(nums []int, k int) bool {
    indexMap := make(map[int]int)
    for i, num := range nums {
        if idx, found := indexMap[num]; found && i-idx <= k {
            return true
        }
        indexMap[num] = i
    }
    return false
}