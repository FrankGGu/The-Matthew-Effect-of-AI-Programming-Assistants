func findMin(nums []int) int {
    low := 0
    high := len(nums) - 1

    for low < high {
        mid := low + (high-low)/2
        if nums[mid] < nums[high] {
            high = mid
        } else if nums[mid] > nums[high] {
            low = mid + 1
        } else { // nums[mid] == nums[high]
            high--
        }
    }

    return nums[low]
}