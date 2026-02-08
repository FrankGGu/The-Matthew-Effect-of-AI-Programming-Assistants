func mySqrt(x int) int {
    if x == 0 {
        return 0
    }
    left, right := 1, x
    for left <= right {
        mid := left + (right - left) / 2
        sqrt := x / mid
        if mid == sqrt {
            return mid
        } else if mid < sqrt {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return right
}