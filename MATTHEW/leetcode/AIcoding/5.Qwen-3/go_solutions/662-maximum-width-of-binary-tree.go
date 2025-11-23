package main


func widthOfBinaryTree(root *TreeNode) int {
    if root == nil {
        return 0
    }
    type entry struct {
        node  *TreeNode
        index int
    }
    queue := []entry{{root, 0}}
    maxWidth := 0
    for len(queue) > 0 {
        levelSize := len(queue)
        left := queue[0].index
        right := queue[0].index
        for i := 0; i < levelSize; i++ {
            current := queue[0]
            queue = queue[1:]
            if i == 0 {
                left = current.index
            }
            if i == levelSize-1 {
                right = current.index
            }
            if current.node.Left != nil {
                queue = append(queue, entry{current.node.Left, current.index * 2})
            }
            if current.node.Right != nil {
                queue = append(queue, entry{current.node.Right, current.index * 2 + 1})
            }
        }
        maxWidth = max(maxWidth, right-left+1)
    }
    return maxWidth
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}