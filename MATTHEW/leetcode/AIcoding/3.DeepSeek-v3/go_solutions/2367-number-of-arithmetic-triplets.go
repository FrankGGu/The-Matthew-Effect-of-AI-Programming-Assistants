func arithmeticTriplets(nums []int, diff int) int {
    count := 0
    set := make(map[int]bool)
    for _, num := range nums {
        set[num] = true
    }
    for _, num := range nums {
        if set[num + diff] && set[num + 2 * diff] {
            count++
        }
    }
    return count
}