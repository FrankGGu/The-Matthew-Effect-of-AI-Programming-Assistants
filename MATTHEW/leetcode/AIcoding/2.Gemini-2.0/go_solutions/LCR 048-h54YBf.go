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
		return "nil,"
	}
	return strconv.Itoa(root.Val) + "," + this.serialize(root.Left) + this.serialize(root.Right)
}

func (this *Codec) deserialize(data string) *TreeNode {
	nodes := strings.Split(data, ",")
	var deserializeHelper func() *TreeNode
	i := 0
	deserializeHelper = func() *TreeNode {
		if i >= len(nodes)-1 {
			return nil
		}
		if nodes[i] == "nil" {
			i++
			return nil
		}
		val, _ := strconv.Atoi(nodes[i])
		i++
		node := &TreeNode{Val: val}
		node.Left = deserializeHelper()
		node.Right = deserializeHelper()
		return node
	}
	return deserializeHelper()
}