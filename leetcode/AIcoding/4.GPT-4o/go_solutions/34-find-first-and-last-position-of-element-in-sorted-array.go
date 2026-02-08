func searchRange(nums []int, target int) []int {
    left := search(nums, target, true)
    if left == len(nums) || nums[left] != target {
        return []int{-1, -1}
    }
    right := search(nums, target, false) - 1
    return []int{left, right}
}

func search(nums []int, target int, findFirst bool) int {
    low, high := 0, len(nums)
    for low < high {
        mid := low + (high-low)/2
        if nums[mid] < target || (findFirst && nums[mid] == target) {
            low = mid + 1
        } else {
            high = mid
        }
    }
    return low
}