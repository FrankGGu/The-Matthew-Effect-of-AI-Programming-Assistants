func countTarget(scores []int, target int) int {
    left := findFirst(scores, target)
    if left == -1 {
        return 0
    }
    right := findLast(scores, target)
    return right - left + 1
}

func findFirst(nums []int, target int) int {
    left, right := 0, len(nums)-1
    res := -1
    for left <= right {
        mid := left + (right-left)/2
        if nums[mid] >= target {
            right = mid - 1
        } else {
            left = mid + 1
        }
        if nums[mid] == target {
            res = mid
        }
    }
    return res
}

func findLast(nums []int, target int) int {
    left, right := 0, len(nums)-1
    res := -1
    for left <= right {
        mid := left + (right-left)/2
        if nums[mid] <= target {
            left = mid + 1
        } else {
            right = mid - 1
        }
        if nums[mid] == target {
            res = mid
        }
    }
    return res
}