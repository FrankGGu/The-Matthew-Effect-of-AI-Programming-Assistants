/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

type Codec struct {

}

func Constructor() Codec {
    return Codec{}
}

// Serializes a tree to a single string.
func (this *Codec) serialize(root *TreeNode) string {
    if root == nil {
        return "null"
    }
    left := this.serialize(root.Left)
    right := this.serialize(root.Right)
    return strconv.Itoa(root.Val) + "," + left + "," + right
}

// Deserializes your encoded data to tree.
func (this *Codec) deserialize(data string) *TreeNode {    
    nodes := strings.Split(data, ",")
    var index int
    return helper(&index, nodes)
}

func helper(index *int, nodes []string) *TreeNode {
    if nodes[*index] == "null" {
        *index++
        return nil
    }
    val, _ := strconv.Atoi(nodes[*index])
    *index++
    node := &TreeNode{Val: val}
    node.Left = helper(index, nodes)
    node.Right = helper(index, nodes)
    return node
}

/**
 * Your Codec object will be instantiated and called as such:
 * ser := Constructor();
 * deser := Constructor();
 * data := ser.serialize(root);
 * ans := deser.deserialize(data);
 */