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
		return "null"
	}

	var sb strings.Builder
	var dfs func(*TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			sb.WriteString("null,")
			return
		}
		sb.WriteString(strconv.Itoa(node.Val))
		sb.WriteString(",")
		dfs(node.Left)
		dfs(node.Right)
	}

	dfs(root)
	res := sb.String()
	// Remove the trailing comma for a cleaner string representation
	if len(res) > 0 && res[len(res)-1] == ',' {
		res = res[:len(res)-1]
	}
	return res
}

func (this *Codec) deserialize(data string) *TreeNode {
	if data == "null" {
		return nil
	}

	vals := strings.Split(data, ",")
	idx := 0

	var buildTree func() *TreeNode
	buildTree = func() *TreeNode {
		if idx >= len(vals) || vals[idx] == "null" {
			idx++
			return nil
		}

		val, _ := strconv.Atoi(vals[idx])
		node := &TreeNode{Val: val}
		idx++

		node.Left = buildTree()
		node.Right = buildTree()

		return node
	}

	return buildTree()
}