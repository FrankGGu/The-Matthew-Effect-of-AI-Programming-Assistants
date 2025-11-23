func guessNumber(n int) int {
    low := 1
    high := n
    for low <= high {
        mid := low + (high - low) / 2
        res := guess(mid)
        if res == 0 {
            return mid
        } else if res < 0 {
            high = mid - 1
        } else {
            low = mid + 1
        }
    }
    return -1
}