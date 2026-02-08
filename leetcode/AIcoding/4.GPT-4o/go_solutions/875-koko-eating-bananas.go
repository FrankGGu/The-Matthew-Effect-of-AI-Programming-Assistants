func minEatingSpeed(piles []int, h int) int {
    left, right := 1, 0
    for _, pile := range piles {
        if pile > right {
            right = pile
        }
    }

    for left < right {
        mid := left + (right-left)/2
        if canEatAll(piles, mid, h) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canEatAll(piles []int, k, h int) bool {
    hours := 0
    for _, pile := range piles {
        hours += (pile + k - 1) / k
    }
    return hours <= h
}