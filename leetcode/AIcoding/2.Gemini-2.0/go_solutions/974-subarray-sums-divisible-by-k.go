func subarraysDivByK(nums []int, k int) int {
    count := 0
    prefixSum := 0
    remainderMap := make(map[int]int)
    remainderMap[0] = 1

    for _, num := range nums {
        prefixSum += num
        remainder := prefixSum % k
        if remainder < 0 {
            remainder += k
        }

        if val, ok := remainderMap[remainder]; ok {
            count += val
            remainderMap[remainder]++
        } else {
            remainderMap[remainder] = 1
        }
    }

    return count
}