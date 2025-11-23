func subarraySum(nums []int, k int) int {
    count := 0
    currentSum := 0
    sumFreq := make(map[int]int)
    sumFreq[0] = 1 // Initialize with sum 0 having one occurrence for cases where currentSum == k

    for _, num := range nums {
        currentSum += num

        // Check if (currentSum - k) exists in the map
        // If it does, it means there are sumFreq[currentSum - k] subarrays
        // ending at the current position that sum up to k.
        if freq, ok := sumFreq[currentSum-k]; ok {
            count += freq
        }

        // Increment the frequency of the current sum
        sumFreq[currentSum]++
    }

    return count
}