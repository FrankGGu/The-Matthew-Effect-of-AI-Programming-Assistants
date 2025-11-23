func minEatingSpeed(piles []int, h int) int {
    left, right := 1, maxPile(piles)

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

func maxPile(piles []int) int {
    max := 0
    for _, p := range piles {
        if p > max {
            max = p
        }
    }
    return max
}

func canEatAll(piles []int, k int, h int) bool {
    hours := 0
    for _, p := range piles {
        hours += p / k
        if p % k != 0 {
            hours++
        }
    }
    return hours <= h
}