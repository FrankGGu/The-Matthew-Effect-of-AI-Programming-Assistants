func findPeakElement(nums []int) int {
    left := 0
    right := len(nums) - 1

    for left < right {
        mid := left + (right-left)/2
        if nums[mid] > nums[mid+1] {
            // We are on a descending slope or at a peak.
            // The peak must be on the left side (including mid).
            right = mid
        } else {
            // nums[mid] < nums[mid+1]
            // We are on an ascending slope.
            // The peak must be on the right side (including mid+1).
            left = mid + 1
        }
    }
    // When left == right, we have found a peak element.
    return left
}