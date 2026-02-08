func maxSubarrays(nums []int) int {
    minAnd := nums[0]
    for _, num := range nums {
        minAnd &= num
    }
    if minAnd != 0 {
        return 1
    }

    res := 0
    currentAnd := (1 << 30) - 1
    for _, num := range nums {
        currentAnd &= num
        if currentAnd == 0 {
            res++
            currentAnd = (1 << 30) - 1
        }
    }
    return res
}