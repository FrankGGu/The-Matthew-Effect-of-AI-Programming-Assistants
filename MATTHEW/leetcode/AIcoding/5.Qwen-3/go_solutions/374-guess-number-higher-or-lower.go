package main

func guess(num int) int {
    // This is a placeholder for the actual implementation.
    // In LeetCode, this function is predefined by the system.
    return 0
}

func guessNumber(n int) int {
    left := 1
    right := n
    for left < right {
        mid := left + (right-left)/2
        if guess(mid) == 0 {
            return mid
        } else if guess(mid) == 1 {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return left
}