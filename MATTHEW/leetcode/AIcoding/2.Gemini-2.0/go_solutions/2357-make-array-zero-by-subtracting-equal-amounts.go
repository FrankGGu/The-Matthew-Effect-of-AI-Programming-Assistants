func minimumOperations(nums []int) int {
    seen := make(map[int]bool)
    count := 0
    for _, num := range nums {
        if num > 0 && !seen[num] {
            seen[num] = true
            count++
        }
    }
    return count
}