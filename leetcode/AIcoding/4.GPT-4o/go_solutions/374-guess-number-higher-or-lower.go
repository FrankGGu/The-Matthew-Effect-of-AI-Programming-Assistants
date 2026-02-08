func guessNumber(n int) int {
    low, high := 1, n
    for low <= high {
        mid := low + (high-low)/2
        res := guess(mid)
        if res == 0 {
            return mid
        } else if res == -1 {
            high = mid - 1
        } else {
            low = mid + 1
        }
    }
    return -1
}