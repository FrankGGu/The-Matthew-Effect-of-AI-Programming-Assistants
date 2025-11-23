package main

func reservoirCapacity(height []int) int {
    if len(height) < 3 {
        return 0
    }
    left := 0
    right := len(height) - 1
    leftMax := height[left]
    rightMax := height[right]
    result := 0
    for left < right {
        if leftMax < rightMax {
            left++
            if height[left] > leftMax {
                leftMax = height[left]
            } else {
                result += leftMax - height[left]
            }
        } else {
            right--
            if height[right] > rightMax {
                rightMax = height[right]
            } else {
                result += rightMax - height[right]
            }
        }
    }
    return result
}