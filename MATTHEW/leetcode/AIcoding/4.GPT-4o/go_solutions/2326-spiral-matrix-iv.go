func spiralMatrix(m int, n int, head *ListNode) [][]int {
    res := make([][]int, m)
    for i := range res {
        res[i] = make([]int, n)
    }

    left, right, top, bottom := 0, n-1, 0, m-1
    for head != nil && top <= bottom && left <= right {
        for i := left; i <= right && head != nil; i++ {
            res[top][i] = head.Val
            head = head.Next
        }
        top++

        for i := top; i <= bottom && head != nil; i++ {
            res[i][right] = head.Val
            head = head.Next
        }
        right--

        for i := right; i >= left && head != nil; i-- {
            res[bottom][i] = head.Val
            head = head.Next
        }
        bottom--

        for i := bottom; i >= top && head != nil; i-- {
            res[i][left] = head.Val
            head = head.Next
        }
        left++
    }

    return res
}