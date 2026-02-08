func minimumOperations(nums []int) int {
    count := 0
    set := make(map[int]bool)
    for _, num := range nums {
        if num > 0 {
            if !set[num] {
                set[num] = true
                count++
            }
        }
    }
    return count
}