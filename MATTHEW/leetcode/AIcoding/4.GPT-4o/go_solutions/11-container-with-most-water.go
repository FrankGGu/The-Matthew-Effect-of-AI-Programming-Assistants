func maxArea(height []int) int {
    left, right := 0, len(height)-1
    maxArea := 0

    for left < right {
        width := right - left
        h := min(height[left], height[right])
        area := width * h
        if area > maxArea {
            maxArea = area
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