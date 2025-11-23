func minimizeArrayValue(nums []int) int {
    left, right := 0, 0
    for _, num := range nums {
        if num > right {
            right = num
        }
    }

    for left < right {
        mid := (left + right) / 2
        if canAchieve(nums, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }

    return left
}

func canAchieve(nums []int, target int) bool {
    total, count := 0, 0
    for _, num := range nums {
        total += num
        if total > target*(count+1) {
            return false
        }
        count++
    }
    return true
}