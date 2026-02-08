func minOperations(boxes string) []int {
    n := len(boxes)
    result := make([]int, n)

    leftCount, rightCount := 0, 0
    leftMoves, rightMoves := 0, 0

    for i := 0; i < n; i++ {
        result[i] = leftMoves + rightMoves
        if boxes[i] == '1' {
            rightCount++
        }
        rightMoves += rightCount
    }

    for i := n - 1; i >= 0; i-- {
        result[i] += leftMoves
        if boxes[i] == '1' {
            leftCount++
        }
        leftMoves += leftCount
    }

    return result
}