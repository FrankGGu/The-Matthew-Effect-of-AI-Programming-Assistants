func minEatingSpeed(piles []int, h int) int {
    left, right := 1, 1
    for _, pile := range piles {
        if pile > right {
            right = pile
        }
    }

    for left < right {
        mid := left + (right-left)/2
        hours := 0
        for _, pile := range piles {
            hours += (pile + mid - 1) / mid
        }
        if hours > h {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}