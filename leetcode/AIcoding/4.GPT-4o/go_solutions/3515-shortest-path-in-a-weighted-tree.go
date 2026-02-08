type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func shortestPath(root *TreeNode, start int, end int) int {
    if root == nil {
        return -1
    }

    var startNode, endNode *TreeNode
    var dfs func(node *TreeNode) bool
    dfs = func(node *TreeNode) bool {
        if node == nil {
            return false
        }
        if node.Val == start {
            startNode = node
        }
        if node.Val == end {
            endNode = node
        }
        return dfs(node.Left) || dfs(node.Right) || (startNode != nil && endNode != nil)
    }

    dfs(root)

    if startNode == nil || endNode == nil {
        return -1
    }

    var lca func(node *TreeNode) *TreeNode
    lca = func(node *TreeNode) *TreeNode {
        if node == nil || node == startNode || node == endNode {
            return node
        }
        left := lca(node.Left)
        right := lca(node.Right)
        if left != nil && right != nil {
            return node
        }
        return left
    }

    ancestor := lca(root)

    var depth func(node *TreeNode, target *TreeNode, d int) int
    depth = func(node *TreeNode, target *TreeNode, d int) int {
        if node == nil {
            return -1
        }
        if node == target {
            return d
        }
        left := depth(node.Left, target, d+1)
        if left != -1 {
            return left
        }
        return depth(node.Right, target, d+1)
    }

    distanceStart := depth(ancestor, startNode, 0)
    distanceEnd := depth(ancestor, endNode, 0)

    return distanceStart + distanceEnd
}