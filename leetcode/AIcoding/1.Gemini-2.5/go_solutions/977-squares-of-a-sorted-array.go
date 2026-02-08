func sortedSquares(nums []int) []int {
    n := len(nums)
    result := make([]int, n)
    left := 0
    right := n - 1

    for i := n - 1; i >= 0; i-- {
        squareLeft := nums[left] * nums