func xorGame(nums []int) bool {
    xorSum := 0
    for _, num := range nums {
        xorSum ^= num
    }
    return xorSum == 0 || len(nums)%2 == 0
}