package main

func nextGreatestLetter(letters []int, target int) int {
    left, right := 0, len(letters)-1
    for left <= right {
        mid := left + (right-left)/2
        if letters[mid] <= target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    if left == len(letters) {
        return letters[0]
    }
    return letters[left]
}