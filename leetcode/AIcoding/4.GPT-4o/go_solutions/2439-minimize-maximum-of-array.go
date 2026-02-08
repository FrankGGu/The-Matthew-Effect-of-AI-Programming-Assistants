func minimizeArrayValue(nums []int) int {
    left, right := 0, 0
    for _, num := range nums {
        if num > right {
            right = num
        }
    }

    for left < right {
        mid := left + (right-left)/2
        if check(nums, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func check(nums []int, target int) bool {
    sum := 0
    for i, num := range nums {
        sum += num
        if sum > target*(i+1) {
            return false
        }
    }
    return true
}