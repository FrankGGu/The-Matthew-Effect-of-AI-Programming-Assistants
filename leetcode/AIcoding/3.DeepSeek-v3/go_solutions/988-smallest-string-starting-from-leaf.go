/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func smallestFromLeaf(root *TreeNode) string {
    var res string
    var dfs func(node *TreeNode, path []byte)
    dfs = func(node *TreeNode, path []byte) {
        if node == nil {
            return
        }
        path = append(path, byte('a' + node.Val))
        if node.Left == nil && node.Right == nil {
            current := make([]byte, len(path))
            copy(current, path)
            reverse(current)
            currentStr := string(current)
            if res == "" || currentStr < res {
                res = currentStr
            }
            return
        }
        dfs(node.Left, path)
        dfs(node.Right, path)
    }
    dfs(root, []byte{})
    return res
}

func reverse(s []byte) {
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        s[i], s[j] = s[j], s[i]
    }
}