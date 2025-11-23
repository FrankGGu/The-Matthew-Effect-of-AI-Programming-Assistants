func numberOfSubarrays(nums []int, k int) int {
    count := 0
    prefixSum := 0
    prefixCount := make([]int, len(nums)+1)
    prefixCount[0] = 1

    for _, num := range nums {
        if num%2 != 0 {
            prefixSum++
        }
        if prefixSum >= k {
            count += prefixCount[prefixSum-k]
        }
        prefixCount[prefixSum]++
    }

    return count
}