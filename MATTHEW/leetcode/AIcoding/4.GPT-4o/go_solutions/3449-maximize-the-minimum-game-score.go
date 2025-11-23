func maximizeMinimum(nums []int, p int) int {
    left, right := 0, 0
    for _, num := range nums {
        if num > right {
            right = num
        }
    }

    for left < right {
        mid := left + (right-left+1)/2
        if canAchieve(nums, mid, p) {
            left = mid
        } else {
            right = mid - 1
        }
    }

    return left
}

func canAchieve(nums []int, minScore int, p int) bool {
    count := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] >= minScore {
            count++
            i++
        }
    }
    return count >= p
}