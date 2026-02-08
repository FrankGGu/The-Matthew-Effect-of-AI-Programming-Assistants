func minimumPerimeter(neededApples int64) int64 {
    var left, right int64 = 1, 1e5
    for left < right {
        mid := left + (right-left)/2
        total := 2 * mid * (mid + 1) * (2*mid + 1)
        if total < neededApples {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return 8 * left
}