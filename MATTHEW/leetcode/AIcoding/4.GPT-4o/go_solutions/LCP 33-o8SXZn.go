func trap(height []int) int {
    n := len(height)
    if n == 0 {
        return 0
    }

    left, right := 0, n-1
    leftMax, rightMax := height[left], height[right]
    result := 0

    for left < right {
        if leftMax < rightMax {
            left++
            if height[left] < leftMax {
                result += leftMax - height[left]
            } else {
                leftMax = height[left]
            }
        } else {
            right--
            if height[right] < rightMax {
                result += rightMax - height[right]
            } else {
                rightMax = height[right]
            }
        }
    }

    return result
}