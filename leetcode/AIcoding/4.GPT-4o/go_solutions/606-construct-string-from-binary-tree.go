package main

import "strings"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func tree2str(root *TreeNode) string {
    if root == nil {
        return ""
    }
    sb := strings.Builder{}
    sb.WriteString(fmt.Sprintf("%d", root.Val))
    if root.Left != nil {
        sb.WriteString("(" + tree2str(root.Left) + ")")
    }
    if root.Right != nil {
        if root.Left == nil {
            sb.WriteString("()")
        }
        sb.WriteString("(" + tree2str(root.Right) + ")")
    }
    return sb.String()
}