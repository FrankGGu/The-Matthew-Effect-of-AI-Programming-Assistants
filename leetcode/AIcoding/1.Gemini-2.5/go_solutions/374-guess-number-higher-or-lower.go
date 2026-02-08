func guessNumber(n int) int {
    low := 1
    high := n

    for low <= high {
        mid := low + (high - low) / 2
        result := guess(mid)

        if result == 0 {
            return mid
        } else if result == 1 {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return -1
}