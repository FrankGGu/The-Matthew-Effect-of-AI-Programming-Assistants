package main

import "math"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func collectCoins(root *TreeNode) int {
    if root == nil {
        return 0
    }
    coins, moves := dfs(root)
    if coins > 0 {
        return moves + coins - 1
    }
    return moves
}

func dfs(node *TreeNode) (int, int) {
    if node == nil {
        return 0, 0
    }
    leftCoins, leftMoves := dfs(node.Left)
    rightCoins, rightMoves := dfs(node.Right)

    totalCoins := leftCoins + rightCoins + node.Val
    moves := leftMoves + rightMoves + int(math.Max(0, float64(leftCoins))) + int(math.Max(0, float64(rightCoins)))

    return totalCoins - 1, moves
}