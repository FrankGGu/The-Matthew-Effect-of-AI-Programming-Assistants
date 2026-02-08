/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
type NodeInfo struct {
    row, col, val int
}

func verticalTraversal(root *TreeNode) [][]int {
    nodes := []NodeInfo{}
    traverse(root, 0, 0, &nodes)

    sort.Slice(nodes, func(i, j int) bool {
        if nodes[i].col != nodes[j].col {
            return nodes[i].col < nodes[j].col
        }
        if nodes[i].row != nodes[j].row {
            return nodes[i].row < nodes[j].row
        }
        return nodes[i].val < nodes[j].val
    })

    res := [][]int{}
    if len(nodes) == 0 {
        return res
    }
    currentCol := nodes[0].col
    currentList := []int{nodes[0].val}

    for i := 1; i < len(nodes); i++ {
        if nodes[i].col == currentCol {
            currentList = append(currentList, nodes[i].val)
        } else {
            res = append(res, currentList)
            currentCol = nodes[i].col
            currentList = []int{nodes[i].val}
        }
    }
    res = append(res, currentList)
    return res
}

func traverse(node *TreeNode, row, col int, nodes *[]NodeInfo) {
    if node == nil {
        return
    }
    *nodes = append(*nodes, NodeInfo{row, col, node.Val})
    traverse(node.Left, row+1, col-1, nodes)
    traverse(node.Right, row+1, col+1, nodes)
}