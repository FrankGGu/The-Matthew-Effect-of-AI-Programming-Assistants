func maxElements(nums []int, limit int) int {
    count := 0
    total := 0
    for _, num := range nums {
        total += num
        if total > limit {
            break
        }
        count++
    }
    return count
}