package main


func pseudoPalindromicPaths (root *TreeNode) int {
    var count func(*TreeNode, int) int
    count = func(node *TreeNode, path int) int {
        if node == nil {
            return 0
        }
        path ^= 1 << uint(node.Val)
        if node.Left == nil && node.Right == nil {
            if path&(path-1) == 0 {
                return 1
            }
            return 0
        }
        return count(node.Left, path) + count(node.Right, path)
    }
    return count(root, 0)
}