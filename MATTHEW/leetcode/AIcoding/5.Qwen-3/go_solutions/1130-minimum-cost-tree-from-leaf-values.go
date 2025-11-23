package main

func mctAlphaBeta(root *TreeNode, memo map[[2]int]int) int {
    if root == nil {
        return 0
    }
    if left, ok := memo[[2]int{root.Val, root.Val}]; ok {
        return left
    }
    if root.Left == nil && root.Right == nil {
        return 0
    }
    leftCost := 0
    rightCost := 0
    if root.Left != nil {
        leftCost = mctAlphaBeta(root.Left, memo)
    }
    if root.Right != nil {
        rightCost = mctAlphaBeta(root.Right, memo)
    }
    leftVal := root.Left.Val
    rightVal := root.Right.Val
    cost := leftVal + rightVal
    totalCost := leftCost + rightCost + cost
    memo[[2]int{root.Val, root.Val}] = totalCost
    return totalCost
}

func mctFromLeafValues(root *TreeNode) int {
    memo := make(map[[2]int]int)
    return mctAlphaBeta(root, memo)
}