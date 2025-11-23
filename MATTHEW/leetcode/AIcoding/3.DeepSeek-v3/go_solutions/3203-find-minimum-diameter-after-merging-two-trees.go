func findMinimumDiameter(t1 *TreeNode, t2 *TreeNode) int {
    nodes1 := []int{}
    nodes2 := []int{}
    inorder(t1, &nodes1)
    inorder(t2, &nodes2)

    merged := merge(nodes1, nodes2)

    return buildAndFindDiameter(merged)
}

func inorder(node *TreeNode, nodes *[]int) {
    if node == nil {
        return
    }
    inorder(node.Left, nodes)
    *nodes = append(*nodes, node.Val)
    inorder(node.Right, nodes)
}

func merge(a, b []int) []int {
    res := make([]int, 0, len(a)+len(b))
    i, j := 0, 0
    for i < len(a) && j < len(b) {
        if a[i] < b[j] {
            res = append(res, a[i])
            i++
        } else {
            res = append(res, b[j])
            j++
        }
    }
    res = append(res, a[i:]...)
    res = append(res, b[j:]...)
    return res
}

func buildAndFindDiameter(nodes []int) int {
    if len(nodes) == 0 {
        return 0
    }
    root := buildBST(nodes, 0, len(nodes)-1)
    return diameter(root)
}

func buildBST(nodes []int, left, right int) *TreeNode {
    if left > right {
        return nil
    }
    mid := left + (right-left)/2
    root := &TreeNode{Val: nodes[mid]}
    root.Left = buildBST(nodes, left, mid-1)
    root.Right = buildBST(nodes, mid+1, right)
    return root
}

func diameter(root *TreeNode) int {
    if root == nil {
        return 0
    }
    maxDia := 0
    var height func(node *TreeNode) int
    height = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := height(node.Left)
        right := height(node.Right)
        maxDia = max(maxDia, left+right)
        return max(left, right) + 1
    }
    height(root)
    return maxDia
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}