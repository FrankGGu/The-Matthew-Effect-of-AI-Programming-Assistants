func findFinalValue(nums []int, original int) int {
    m := make(map[int]bool)
    for _, num := range nums {
        m[num] = true
    }
    for m[original] {
        original *= 2
    }
    return original
}