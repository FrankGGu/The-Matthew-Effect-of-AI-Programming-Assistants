import (
	"strconv"
	"strings"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

type Codec struct {
}

func Constructor() Codec {
	return Codec{}
}

func (this *Codec) serialize(root *TreeNode) string {
	if root == nil {
		return "null,"
	}
	return strconv.Itoa(root.Val) + "," + this.serialize(root.Left) + this.serialize(root.Right)
}

func (this *Codec) deserialize(data string) *TreeNode {
	vals := strings.Split(data, ",")
	var i int
	var build func() *TreeNode
	build = func() *TreeNode {
		if vals[i] == "null" {
			i++
			return nil
		}
		val, _ := strconv.Atoi(vals[i])
		i++
		node := &TreeNode{Val: val}
		node.Left = build()
		node.Right = build()
		return node
	}
	return build()
}