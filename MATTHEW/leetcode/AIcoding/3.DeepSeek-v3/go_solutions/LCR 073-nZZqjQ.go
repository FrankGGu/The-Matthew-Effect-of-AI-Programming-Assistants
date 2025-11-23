func minEatingSpeed(piles []int, h int) int {
    left, right := 1, 1
    for _, pile := range piles {
        if pile > right {
            right = pile
        }
    }

    for left < right {
        mid := left + (right-left)/2
        total := 0
        for _, pile := range piles {
            total += (pile + mid - 1) / mid
        }
        if total <= h {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}