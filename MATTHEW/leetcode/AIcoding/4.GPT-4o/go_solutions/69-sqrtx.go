func mySqrt(x int) int {
    if x < 2 {
        return x
    }
    left, right := 2, x/2
    for left <= right {
        mid := left + (right-left)/2
        square := mid * mid
        if square == x {
            return mid
        } else if square < x {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return right
}