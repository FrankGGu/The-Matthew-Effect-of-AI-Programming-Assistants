func minCapability(nums []int, k int) int {
    left, right := 1, 1
    for _, num := range nums {
        if num > right {
            right = num
        }
    }

    for left < right {
        mid := left + (right-left)/2
        count := 0
        taken := false
        for _, num := range nums {
            if !taken && num <= mid {
                count++
                taken = true
            } else {
                taken = false
            }
        }
        if count >= k {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}