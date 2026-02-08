func separateSquares(nums []int) []int {
    n := len(nums)
    left, right := 0, n-1
    res := make([]int, n)
    idx := n-1

    for left <= right {
        leftSquare := nums[left] * nums[left]
        rightSquare := nums[right] * nums[right]

        if leftSquare > rightSquare {
            res[idx] = leftSquare
            left++
        } else {
            res[idx] = rightSquare
            right--
        }
        idx--
    }

    return res
}