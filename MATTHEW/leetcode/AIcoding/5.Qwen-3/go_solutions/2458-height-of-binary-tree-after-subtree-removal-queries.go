package main


func treeQueries(root *TreeNode, queries []int) []int {
    height := make(map[int]int)
    nodeToParent := make(map[*TreeNode]*TreeNode)
    nodeToDepth := make(map[*TreeNode]int)

    var dfs func(*TreeNode, int) int
    dfs = func(node *TreeNode, depth int) int {
        if node == nil {
            return -1
        }
        nodeToDepth[node] = depth
        leftHeight := dfs(node.Left, depth+1)
        rightHeight := dfs(node.Right, depth+1)
        h := 1 + max(leftHeight, rightHeight)
        height[node.Val] = h
        if node.Left != nil {
            nodeToParent[node.Left] = node
        }
        if node.Right != nil {
            nodeToParent[node.Right] = node
        }
        return h
    }

    dfs(root, 0)

    result := make([]int, len(queries))
    for i, q := range queries {
        node := findNode(root, q)
        if node == nil {
            result[i] = 0
            continue
        }
        parent := nodeToParent[node]
        if parent == nil {
            result[i] = -1
            continue
        }
        left := parent.Left
        right := parent.Right
        maxSubHeight := -1
        if left != nil && left != node {
            maxSubHeight = max(maxSubHeight, height[left.Val])
        }
        if right != nil && right != node {
            maxSubHeight = max(maxSubHeight, height[right.Val])
        }
        result[i] = maxSubHeight
    }
    return result
}

func findNode(root *TreeNode, val int) *TreeNode {
    if root == nil {
        return nil
    }
    if root.Val == val {
        return root
    }
    left := findNode(root.Left, val)
    if left != nil {
        return left
    }
    return findNode(root.Right, val)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}