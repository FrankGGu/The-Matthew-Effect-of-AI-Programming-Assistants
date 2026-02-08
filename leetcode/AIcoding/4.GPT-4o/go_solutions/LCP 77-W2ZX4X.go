func minRuneReserve(runes []int, m int) int {
    n := len(runes)
    left, right := 0, m
    for left < right {
        mid := left + (right-left)/2
        if canAchieve(runes, mid, m) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canAchieve(runes []int, reserve int, m int) bool {
    total := 0
    for _, r := range runes {
        total += r - reserve
        if total < 0 {
            return false
        }
    }
    return total >= m
}