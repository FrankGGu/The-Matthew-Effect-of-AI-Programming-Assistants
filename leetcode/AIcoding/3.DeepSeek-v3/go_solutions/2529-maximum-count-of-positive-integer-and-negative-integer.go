func maximumCount(nums []int) int {
    pos, neg := 0, 0
    for _, num := range nums {
        if num > 0 {
            pos++
        } else if num < 0 {
            neg++
        }
    }
    if pos > neg {
        return pos
    }
    return neg
}