package main

func minEatingSpeed(piles []int, h int) int {
    left := 1
    right := 1
    for _, pile := range piles {
        if pile > right {
            right = pile
        }
    }

    for left < right {
        mid := (left + right) / 2
        if canEat(piles, mid, h) {
            right = mid
        } else {
            left = mid + 1
        }
    }

    return left
}

func canEat(piles []int, speed int, h int) bool {
    hours := 0
    for _, pile := range piles {
        hours += (pile + speed - 1) / speed
        if hours > h {
            return false
        }
    }
    return true
}