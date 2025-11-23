func maxArea(height []int) int {
    max, left, right := 0, 0, len(height)-1
    for left < right {
        h := min(height[left], height[right])
        w := right - left
        area := h * w
        if area > max {
            max = area
        }
        if height[left] < height[right] {
            left++
        } else {
            right--
        }
    }
    return max
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}