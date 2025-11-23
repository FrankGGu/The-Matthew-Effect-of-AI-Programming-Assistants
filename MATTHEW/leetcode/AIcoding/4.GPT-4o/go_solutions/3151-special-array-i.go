func specialArray(nums []int) int {
    for x := 0; x <= len(nums); x++ {
        count := 0
        for _, num := range nums {
            if num >= x {
                count++
            }
        }
        if count == x {
            return x
        }
    }
    return -1
}