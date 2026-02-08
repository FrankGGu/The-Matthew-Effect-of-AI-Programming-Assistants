func beautifulSubarrays(nums []int) int64 {
    prefix := 0
    count := make(map[int]int)
    count[0] = 1
    res := int64(0)

    for _, num := range nums {
        prefix ^= num
        res += int64(count[prefix])
        count[prefix]++
    }

    return res
}