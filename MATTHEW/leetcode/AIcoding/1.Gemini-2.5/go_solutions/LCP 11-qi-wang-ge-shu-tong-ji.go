func expectNumber(nums []int) int {
    seen := make(map[int]bool)
    for _, num := range nums {
        seen[num] = true
    }
    return len(seen)
}