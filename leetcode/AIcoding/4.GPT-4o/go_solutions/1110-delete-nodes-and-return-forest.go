/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */
func delNodes(root *TreeNode, to_delete []int) []*TreeNode {
    deleteSet := make(map[int]struct{})
    for _, val := range to_delete {
        deleteSet[val] = struct{}{}
    }

    var forest []*TreeNode
    var dfs func(node *TreeNode, isRoot bool) *TreeNode
    dfs = func(node *TreeNode, isRoot bool) *TreeNode {
        if node == nil {
            return nil
        }
        if _, found := deleteSet[node.Val]; found {
            if isRoot {
                return nil
            }
            return nil
        }
        if isRoot {
            forest = append(forest, node)
        }
        node.Left = dfs(node.Left, false)
        node.Right = dfs(node.Right, false)
        return node
    }

    dfs(root, true)
    return forest
}