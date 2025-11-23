package main


func findTilt(root *TreeNode) int {
    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        return left + right + node.Val
    }
    var tilt int
    var calcTilt func(*TreeNode)
    calcTilt = func(node *TreeNode) {
        if node == nil {
            return
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        tilt += abs(left - right)
        calcTilt(node.Left)
        calcTilt(node.Right)
    }
    calcTilt(root)
    return tilt
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}