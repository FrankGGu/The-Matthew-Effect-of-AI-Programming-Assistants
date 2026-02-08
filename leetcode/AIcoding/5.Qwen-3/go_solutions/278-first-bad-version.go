package main

func firstBadVersion(n int) int {
    left, right := 1, n
    for left < right {
        mid := left + (right-left)/2
        if isBadVersion(mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func isBadVersion(version int) bool {
    // This function is provided by LeetCode and is not part of the solution
    // It is used to check if a version is bad
    return false
}