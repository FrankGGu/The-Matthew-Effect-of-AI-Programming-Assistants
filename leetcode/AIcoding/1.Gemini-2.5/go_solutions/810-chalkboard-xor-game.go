func xorGame(nums []int) bool {
    xorSum := 0
    for _, num := range nums {
        xorSum ^= num
    }

    if xorSum == 0 {
        return true
    }

    // If xorSum is not 0, Alice wins if and only if the