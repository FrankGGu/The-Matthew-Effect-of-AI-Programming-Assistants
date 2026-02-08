/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

import (
    "strconv"
    "strings"
)

type Codec struct {
}

func Constructor() Codec {
    return Codec{}
}

// Serializes a tree to a single string.
func (this *Codec) serialize(root *TreeNode) string {
    if root == nil {
        return ""
    }
    var res []string
    var queue []*TreeNode
    queue = append(queue, root)
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        if node != nil {
            res = append(res, strconv.Itoa(node.Val))
            queue = append(queue, node.Left)
            queue = append(queue, node.Right)
        } else {
            res = append(res, "null")
        }
    }
    return strings.Join(res, ",")
}

// Deserializes your encoded data to tree.
func (this *Codec) deserialize(data string) *TreeNode {
    if len(data) == 0 {
        return nil
    }
    parts := strings.Split(data, ",")
    val, _ := strconv.Atoi(parts[0])
    root := &TreeNode{Val: val}
    var queue []*TreeNode
    queue = append(queue, root)
    i := 1
    for len(queue) > 0 && i < len(parts) {
        node := queue[0]
        queue = queue[1:]
        if parts[i] != "null" {
            val, _ := strconv.Atoi(parts[i])
            node.Left = &TreeNode{Val: val}
            queue = append(queue, node.Left)
        }
        i++
        if i < len(parts) && parts[i] != "null" {
            val, _ := strconv.Atoi(parts[i])
            node.Right = &TreeNode{Val: val}
            queue = append(queue, node.Right)
        }
        i++
    }
    return root
}

/**
 * Your Codec object will be instantiated and called as such:
 * ser := Constructor()
 * deser := Constructor()
 * tree := ser.serialize(root)
 * ans := deser.deserialize(tree)
 * return ans
 */