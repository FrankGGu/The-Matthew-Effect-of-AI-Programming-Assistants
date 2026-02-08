package main

import "fmt"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func btreeGameWinningMove(root *TreeNode, n int, x int) bool {
    var countSubtree func(node *TreeNode) int
    countSubtree = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        leftCount := countSubtree(node.Left)
        rightCount := countSubtree(node.Right)
        if node.Val == x {
            countX = leftCount + rightCount
        }
        return leftCount + rightCount + 1
    }

    countSubtree(root)

    part1 := countX
    part2 := n - part1 - 1

    return part1 < part2 || part1 < n/2 || part2 < n/2
}

var countX int

func main() {
    // You can test the function here with specific test cases
}