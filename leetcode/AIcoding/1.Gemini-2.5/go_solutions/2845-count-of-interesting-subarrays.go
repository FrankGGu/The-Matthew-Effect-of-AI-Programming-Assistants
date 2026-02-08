func countInterestingSubarrays(nums []int, k int, modulo int) int64 {
    ans := int64(0)
    currentPrefixSum := 0
    freq := make(map[int]int)
    freq[0] = 1 // Initialize for the empty prefix sum before index 0

    for _, num := range nums {
        val := 0
        if num >= k {
            val = 1
        } else {
            val = -1
        }
        currentPrefixSum += val

        // Calculate the remainder, ensuring it's non-negative
        remainder := (currentPrefixSum % modulo + modulo) % modulo

        // Add the count of previous prefix sums that have the same remainder
        // These represent valid starting points for interesting subarrays ending at the current position
        ans += int64(freq[remainder])

        // Increment the frequency for the current remainder
        freq[remainder]++
    }

    return ans
}