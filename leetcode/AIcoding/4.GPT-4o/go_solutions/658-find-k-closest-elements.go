func findClosestElements(arr []int, k int, x int) []int {
    left, right := 0, len(arr)-1
    for right-left >= k {
        if abs(arr[left]-x) > abs(arr[right]-x) {
            right--
        } else {
            left++
        }
    }
    return arr[left : left+k]
}

func abs(val int) int {
    if val < 0 {
        return -val
    }
    return val
}