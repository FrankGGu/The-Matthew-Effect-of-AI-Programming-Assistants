func singleNumber(nums []int) int {
    key := 0
    for _, num := range nums {
        key ^= num
    }
    return key
}