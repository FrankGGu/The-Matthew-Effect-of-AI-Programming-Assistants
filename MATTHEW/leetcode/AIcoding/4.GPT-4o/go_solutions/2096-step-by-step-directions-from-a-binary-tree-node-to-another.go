/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func getDirections(root *TreeNode, startValue int, destValue int) string {
    var startPath, destPath []int
    var dfs func(node *TreeNode, target int, path []int) bool

    dfs = func(node *TreeNode, target int, path []int) bool {
        if node == nil {
            return false
        }
        path = append(path, node.Val)
        if node.Val == target {
            return true
        }
        if dfs(node.Left, target, path) || dfs(node.Right, target, path) {
            return true
        }
        return false
    }

    dfs(root, startValue, startPath)
    dfs(root, destValue, destPath)

    i := 0
    for i < len(startPath) && i < len(destPath) && startPath[i] == destPath[i] {
        i++
    }

    stepsUp := len(startPath) - i
    stepsDown := len(destPath) - i

    result := strings.Repeat("U", stepsUp) + strings.Join(make([]string, stepsDown), "D")

    return result
}