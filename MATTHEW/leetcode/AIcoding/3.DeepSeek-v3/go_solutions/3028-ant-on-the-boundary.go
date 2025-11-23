func returnToBoundaryCount(nums []int) int {
    position := 0
    count := 0
    for _, num := range nums {
        position += num
        if position == 0 {
            count++
        }
    }
    return count
}