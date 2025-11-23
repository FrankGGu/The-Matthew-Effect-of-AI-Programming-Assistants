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
    return strconv.Itoa(root.Val) + "," + this.serialize(root.Left) + "," + this.serialize(root.Right)
}

// Deserializes your encoded data to tree.
func (this *Codec) deserialize(data string) *TreeNode {    
    nodes := strings.Split(data, ",")
    return helper(&nodes)
}

func helper(nodes *[]string) *TreeNode {
    if len(*nodes) == 0 {
        return nil
    }
    val := (*nodes)[0]
    *nodes = (*nodes)[1:]
    if val == "null" {
        return nil
    }
    num, _ := strconv.Atoi(val)
    node := &TreeNode{Val: num}
    node.Left = helper(nodes)
    node.Right = helper(nodes)
    return node
}

/**
 * Your Codec object will be instantiated and called as such:
 * ser := Constructor();
 * deser := Constructor();
 * data := ser.serialize(root);
 * ans := deser.deserialize(data);
 */