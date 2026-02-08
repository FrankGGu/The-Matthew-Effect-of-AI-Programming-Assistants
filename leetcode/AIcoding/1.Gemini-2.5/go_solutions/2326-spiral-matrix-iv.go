func spiralMatrix(m int, n int, head *ListNode) [][]int {
    ans := make([][]int, m)
    for i := range ans {
        ans[i] = make([]int, n)
    }

    top, bottom := 0, m-1
    left, right := 0, n-1
    curr := head

    for top <= bottom && left <= right {
        // Traverse right
        for c := left; c <= right; c++ {
            if curr != nil {
                ans[top][c] = curr.Val
                curr = curr.Next
            } else {
                ans[top][c] = -1
            }
        }
        top++

        // Traverse down
        for r := top; r <= bottom; r++ {
            if curr != nil {
                ans[r][right] = curr.Val
                curr = curr.Next
            } else {
                ans[r][right] = -1
            }
        }
        right--

        // Traverse left (only if there's a row left)
        if top <= bottom {
            for c := right; c >= left; c-- {
                if curr != nil {
                    ans[bottom][c] = curr.Val
                    curr = curr.Next
                } else {
                    ans[bottom][c] = -1
                }
            }
            bottom--
        }

        // Traverse up (only if there's a column left)
        if left <= right {
            for r := bottom; r >= top; r-- {
                if curr != nil {
                    ans[r][left] = curr.Val
                    curr = curr.Next
                } else {
                    ans[r][left] = -1
                }
            }
            left++
        }
    }

    return ans
}