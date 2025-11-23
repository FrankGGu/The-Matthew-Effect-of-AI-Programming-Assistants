func isPerfectSquare(num int) bool {
    if num < 1 {
        return false
    }

    low := 1
    high := num

    for low <= high {
        mid := low + (high - low) / 2

        // Use int64 for square to prevent overflow, as num can be up