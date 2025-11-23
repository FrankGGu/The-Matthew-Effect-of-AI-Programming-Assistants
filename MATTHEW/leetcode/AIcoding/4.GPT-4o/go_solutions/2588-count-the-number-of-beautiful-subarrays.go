func beautifulSubarrays(nums []int) int64 {
    prefix := map[int]int{0: 1}
    count, sum := int64(0), 0

    for _, num := range nums {
        if num&1 == 1 {
            sum++
        } else {
            sum--
        }
        count += int64(prefix[sum])
        prefix[sum]++
    }

    return count
}