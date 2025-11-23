func isPerfectSquare(num int) bool {
    if num < 2 {
        return true
    }
    left, right := 2, num/2
    for left <= right {
        mid := left + (right-left)/2
        guess := mid * mid
        if guess == num {
            return true
        } else if guess > num {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return false
}