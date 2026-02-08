import "math"

func minTaps(n int, ranges []int) int {
    maxReach := make([]int, n+1)
    // maxReach[i] will store the maximum right endpoint reachable if we start at position i
    // using any single tap that covers position i.
    // Initialize with 0s.
    // For example, if maxReach[j] = k, it means from point j, we can reach up to k.

    for i := 0; i <= n; i++ {
        r := ranges[i]
        left := int(math.Max(0, float64(i - r)))
        right := int(math.Min(float64(n), float64(i + r)))

        // For each tap, it covers a segment [left, right].
        // We are interested in the furthest point reachable from any starting point.
        // If a tap covers [left, right], it means from 'left' we can reach 'right'.
        // We want to store the maximum 'right' for each 'left' possible.
        maxReach[left] = int(math.Max(float64(maxReach[left]), float64(right)))
    }

    taps := 0
    currentEnd := 0 // The current rightmost point covered by selected taps
    nextEnd := 0    // The furthest point we can reach by selecting one more tap
    i := 0          // Pointer for iterating through maxReach array (potential start points)

    // We need to cover the range [0, n].
    for currentEnd < n {
        taps++
        // Find the best tap that starts within the currently covered range [0, currentEnd]
        // and extends furthest.
        // 'i' iterates through possible starting points of taps.
        // We consider all taps that start at or before 'currentEnd'.
        for i <= currentEnd {
            nextEnd = int(math.Max(float64(nextEnd), float64(maxReach[i])))
            i++
        }

        // If nextEnd is not greater than currentEnd, it means we couldn't extend the coverage.
        // This implies it's impossible to cover the entire garden.
        if nextEnd <= currentEnd {
            return -1
        }
        // Update currentEnd to the new maximum reach.
        currentEnd = nextEnd
    }

    return taps
}