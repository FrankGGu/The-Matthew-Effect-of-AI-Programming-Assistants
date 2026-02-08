package main

func maxArea(height []int) int {
    left := 0
    right := len(height) - 1
    maxArea := 0
    for left < right {
        currentArea := min(height[left], height[right]) * (right - left)
        if currentArea > maxArea {
            maxArea = currentArea
        }
        if height[left] < height[right] {
            left++
        } else {
            right--
        }
    }
    return maxArea
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}