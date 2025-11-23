func minImpossibleOR(nums []int) int {
    mask := 0
    for _, num := range nums {
        if (num & (num - 1)) == 0 {
            mask |= num
        }
    }
    res := 1
    for (mask & res) != 0 {
        res <<= 1
    }
    return res
}