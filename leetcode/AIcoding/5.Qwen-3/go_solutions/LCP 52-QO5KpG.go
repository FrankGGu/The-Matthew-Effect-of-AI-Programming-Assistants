package main


func GetDirections(root *TreeNode, startValue int, destValue int) string {
    var findPath func(*TreeNode, int, []byte) bool
    findPath = func(node *TreeNode, target int, path []byte) bool {
        if node == nil {
            return false
        }
        if node.Val == target {
            return true
        }
        if findPath(node.Left, target, append(path, 'L')) {
            return true
        }
        if findPath(node.Right, target, append(path, 'R')) {
            return true
        }
        return false
    }

    var lca func(*TreeNode, int, int) *TreeNode
    lca = func(node *TreeNode, p, q int) *TreeNode {
        if node == nil {
            return nil
        }
        if node.Val == p || node.Val == q {
            return node
        }
        left := lca(node.Left, p, q)
        right := lca(node.Right, p, q)
        if left != nil && right != nil {
            return node
        }
        if left != nil {
            return left
        }
        return right
    }

    lcaNode := lca(root, startValue, destValue)

    var getPath func(*TreeNode, int, []byte) bool
    getPath = func(node *TreeNode, target int, path []byte) bool {
        if node == nil {
            return false
        }
        if node.Val == target {
            return true
        }
        if getPath(node.Left, target, append(path, 'L')) {
            return true
        }
        if getPath(node.Right, target, append(path, 'R')) {
            return true
        }
        return false
    }

    startPath := make([]byte, 0)
    destPath := make([]byte, 0)
    getPath(lcaNode, startValue, startPath)
    getPath(lcaNode, destValue, destPath)

    result := make([]byte, len(startPath))
    for i := range result {
        result[i] = 'U'
    }
    result = append(result, destPath...)
    return string(result)
}