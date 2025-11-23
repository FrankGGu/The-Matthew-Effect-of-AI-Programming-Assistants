func beautifulSubarrays(nums []int) int64 {
    prefixXOR := make(map[int]int)
    prefixXOR[0] = 1
    var res int64 = 0
    currentXOR := 0

    for _, num := range nums {
        currentXOR ^= num
        res += int64(prefixXOR[currentXOR])
        prefixXOR[currentXOR]++
    }

    return res
}