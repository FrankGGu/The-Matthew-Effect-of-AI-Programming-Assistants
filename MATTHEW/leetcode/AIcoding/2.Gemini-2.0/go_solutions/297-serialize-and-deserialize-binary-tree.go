import (
	"strconv"
	"strings"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func serialize(root *TreeNode) string {
	if root == nil {
		return "null,"
	}
	res := strconv.Itoa(root.Val) + ","
	res += serialize(root.Left)
	res += serialize(root.Right)
	return res
}

func deserialize(data string) *TreeNode {
	nodes := strings.Split(data, ",")
	var i int
	var buildTree func() *TreeNode
	buildTree = func() *TreeNode {
		if nodes[i] == "null" {
			i++
			return nil
		}
		val, _ := strconv.Atoi(nodes[i])
		i++
		node := &TreeNode{Val: val}
		node.Left = buildTree()
		node.Right = buildTree()
		return node
	}
	return buildTree()
}