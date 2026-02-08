func xorGame(nums []int) bool {
    if len(nums)%2 == 0 {
        return true
    }
    xorSum := 0
    for _, num := range nums {
        xorSum ^= num
    }
    return xorSum == 0
}