package main


func isCousins(root *TreeNode, x int, y int) bool {
    var findLevelAndParent func(*TreeNode, int, int, int) (int, *TreeNode)
    findLevelAndParent = func(node *TreeNode, target, level int, parent *TreeNode) (int, *TreeNode) {
        if node == nil {
            return -1, nil
        }
        if node.Val == target {
            return level, parent
        }
        leftLevel, leftParent := findLevelAndParent(node.Left, target, level+1, node)
        if leftLevel != -1 {
            return leftLevel, leftParent
        }
        return findLevelAndParent(node.Right, target, level+1, node)
    }

    levelX, parentX := findLevelAndParent(root, x, 0, nil)
    levelY, parentY := findLevelAndParent(root, y, 0, nil)

    return levelX == levelY && parentX != parentY
}