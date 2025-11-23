/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func getDirections(root *TreeNode, startValue int, destValue int) string {
    var findPath func(*TreeNode, int, *[]byte) bool
    findPath = func(node *TreeNode, target int, path *[]byte) bool {
        if node == nil {
            return false
        }
        if node.Val == target {
            return true
        }
        *path = append(*path, 'L')
        if findPath(node.Left, target, path) {
            return true
        }
        *path = (*path)[:len(*path)-1]

        *path = append(*path, 'R')
        if findPath(node.Right, target, path) {
            return true
        }
        *path = (*path)[:len(*path)-1]

        return false
    }

    var startPath, destPath []byte
    findPath(root, startValue, &startPath)
    findPath(root, destValue, &destPath)

    i := 0
    for i < len(startPath) && i < len(destPath) && startPath[i] == destPath[i] {
        i++
    }

    result := make([]byte, len(startPath)-i + len(destPath)-i)
    for j := i; j < len(startPath); j++ {
        result[j-i] = 'U'
    }
    for j := i; j < len(destPath); j++ {
        result[len(startPath)-i + j-i] = destPath[j]
    }

    return string(result)
}