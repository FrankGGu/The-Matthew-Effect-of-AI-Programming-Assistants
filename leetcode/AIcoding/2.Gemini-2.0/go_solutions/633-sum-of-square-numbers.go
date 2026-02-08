func judgeSquareSum(c int) bool {
    left, right := 0, int(sqrt(float64(c)))
    for left <= right {
        sum := left*left + right*right
        if sum == c {
            return true
        } else if sum < c {
            left++
        } else {
            right--
        }
    }
    return false
}

import "math"

func sqrt(x float64) float64 {
    return math.Sqrt(x)
}