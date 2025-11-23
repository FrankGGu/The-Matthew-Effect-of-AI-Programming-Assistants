func specialArray(nums []int) int {
    n := len(nums)
    for x := 0; x <= n; x++ {
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