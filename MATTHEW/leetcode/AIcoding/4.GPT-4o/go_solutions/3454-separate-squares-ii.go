func separateSquares(arr []int) []int {
    n := len(arr)
    if n == 0 {
        return arr
    }

    left, right := 0, n-1
    for left <= right {
        if isPerfectSquare(arr[left]) {
            left++
        } else {
            arr[left], arr[right] = arr[right], arr[left]
            right--
        }
    }

    return arr
}

func isPerfectSquare(num int) bool {
    if num < 0 {
        return false
    }
    x := int(math.Sqrt(float64(num)))
    return x*x == num
}