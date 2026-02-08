package Codec

import (
    "strconv"
    strings"
)

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

type Codec struct {}

func Constructor() Codec {
    return Codec{}
}

func (this *Codec) serialize(root *TreeNode) string {
    if root == nil {
        return "#"
    }
    return strconv.Itoa(root.Val) + "," + this.serialize(root.Left) + "," + this.serialize(root.Right)
}

func (this *Codec) deserialize(data string) *TreeNode {
    values := strings.Split(data, ",")
    return this.buildTree(&values)
}

func (this *Codec) buildTree(values *[]string) *TreeNode {
    if len(*values) == 0 {
        return nil
    }
    val := (*values)[0]
    *values = (*values)[1:]
    if val == "#" {
        return nil
    }
    nodeVal, _ := strconv.Atoi(val)
    node := &TreeNode{Val: nodeVal}
    node.Left = this.buildTree(values)
    node.Right = this.buildTree(values)
    return node
}