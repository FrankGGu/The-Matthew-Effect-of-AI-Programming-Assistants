/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func createBinaryTree(descriptions [][]int) *TreeNode {
    nodes := make(map[int]*TreeNode)
    children := make(map[int]bool)

    for _, desc := range descriptions {
        parentVal, childVal, isLeft := desc[0], desc[1], desc[2] == 1
        parent, ok := nodes[parentVal]
        if !ok {
            parent = &TreeNode{Val: parentVal}
            nodes[parentVal] = parent
        }
        child, ok := nodes[childVal]
        if !ok {
            child = &TreeNode{Val: childVal}
            nodes[childVal] = child
        }
        if isLeft {
            parent.Left = child
        } else {
            parent.Right = child
        }
        children[childVal] = true
    }

    for val := range nodes {
        if !children[val] {
            return nodes[val]
        }
    }
    return nil
}