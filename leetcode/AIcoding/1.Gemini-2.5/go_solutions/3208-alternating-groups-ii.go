func alternatingGroups(colors []int, k int) int {
    n := len(colors)

    if k == 1 {
        return n
    }

    // Create an extended array to handle circularity.
    // We need enough elements to form a window of size k starting at index n-1.
    // This means we need elements up to colors[n-1], colors[0], ..., colors[k-2].
    // In the extended array, this corresponds to indices n-1, n, ..., n+k-2.
    // So, the extended array needs to have length at least n+k-1.
    extendedColors := make([]int, n+k-1)
    for i := 0; i < n+k-1; i++ {
        extendedColors[i] = colors[i%n]
    }

    // Create a flags array where flags[i] = 1 if extendedColors[i] != extendedColors[i+1], else 0.
    // For a group of k elements starting at index `j` in `colors`, we need
    // colors[j] != colors[j+1], colors[j+1] != colors[j+2], ..., colors[j+k-2] != colors[j+k-1].
    // This corresponds to k-1 conditions.
    // In the `flags` array, these are flags[j], flags[j+1], ..., flags[j+k-2].
    // The last condition for a window starting at `n-1` is extendedColors[n+k-3] != extendedColors[n+k-2].
    // So, the `flags` array needs to go up to index n+k-3. Its length should be n+k-2.
    flags := make([]int, n+k-2)
    for i := 0; i < n+k-2; i++ {
        if extendedColors[i] != extendedColors[i+1] {
            flags[i] = 1
        }
    }

    ans := 0
    currentSum := 0
    targetSum := k - 1

    // Initialize the sum for the first window of k-1 flags (corresponding to colors[0]...colors[k-1])
    for i := 0; i < targetSum; i++ {
        currentSum += flags[i]
    }

    if currentSum == targetSum {
        ans++
    }

    // Slide the window for the remaining n-1 starting positions
    for i := 1; i < n; i++ {
        // Remove the leftmost flag
        currentSum -= flags[i-1]
        // Add the new rightmost flag
        currentSum += flags[i+targetSum-1] // The new rightmost flag is at index i + (k-1) - 1 = i + k - 2
                                            // which is equivalent to i + targetSum - 1
        if currentSum == targetSum {
            ans++
        }
    }

    return ans
}