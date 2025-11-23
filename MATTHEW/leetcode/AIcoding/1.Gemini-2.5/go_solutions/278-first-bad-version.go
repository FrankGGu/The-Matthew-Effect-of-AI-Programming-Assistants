func firstBadVersion(n int) int {
    low := 1
    high := n
    ans := n // Initialize ans to n, as in the worst case, n could be the first bad version.

    for low <= high {
        mid := low + (high - low) / 2 // Prevent potential overflow for (low + high)
        if isBadVersion(mid) {
            ans = mid      // mid is a bad version, it could be the first. Store it and try to find an earlier one.
            high = mid - 1 // Search in the left half
        } else {
            low = mid + 1  // mid is a good version, so the first bad version must be after mid.
        }
    }
    return ans
}