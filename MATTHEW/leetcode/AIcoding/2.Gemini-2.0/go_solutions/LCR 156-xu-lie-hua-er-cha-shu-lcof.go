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
	list := strings.Split(data, ",")
	var build func() *TreeNode
	build = func() *TreeNode {
		if len(list) == 0 {
			return nil
		}
		if list[0] == "null" {
			list = list[1:]
			return nil
		}
		val, _ := strconv.Atoi(list[0])
		list = list[1:]
		root := &TreeNode{Val: val}
		root.Left = build()
		root.Right = build()
		return root
	}
	return build()
}