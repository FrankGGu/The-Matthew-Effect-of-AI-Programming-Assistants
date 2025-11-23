func getSubarrayBeauty(nums []int, k int, x int) []int {
    n := len(nums)
    result := make([]int, 0, n-k+1)

    // counts array to store frequencies of numbers in the range [-50, 50]
    // index i corresponds to value i-50
    // e.g., counts[0] for -50, counts[50] for 0, counts[100] for 50
    counts := make([]int, 101) 

    for i := 0; i < n; i++ {
        // Add current element to the window
        counts[nums[i]+50]++

        // If window is full (size k)
        if i >= k-1 {
            currentCount := 0
            beauty := 0

            // Find the x-th smallest element
            for j := 0; j <= 100; j++ {
                currentCount += counts[j]
                if currentCount >= x {
                    val := j - 50
                    if val < 0 {
                        beauty = val
                    } else {
                        beauty = 0
                    }
                    break
                }
            }
            result = append(result, beauty)

            // Remove the element leaving the window
            counts[nums[i-(k-1)]+50]--
        }
    }

    return result
}