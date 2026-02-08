package main

type Codec struct {
}

func Constructor() Codec {
	return Codec{}
}

func (c *Codec) serialize(root *TreeNode) string {
	if root == nil {
		return ""
	}
	var sb strings.Builder
	var dfs func(*TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			sb.WriteString("nil,")
			return
		}
		sb.WriteString(fmt.Sprintf("%d,", node.Val))
		dfs(node.Left)
		dfs(node.Right)
	}
	dfs(root)
	return sb.String()
}

func (c *Codec) deserialize(data string) *TreeNode {
	if data == "" {
		return nil
	}
	nodes := strings.Split(data, ",")
	var build func() *TreeNode
	build = func() *TreeNode {
		if nodes[0] == "nil" {
			nodes = nodes[1:]
			return nil
		}
		val, _ := strconv.Atoi(nodes[0])
		nodes = nodes[1:]
		node := &TreeNode{Val: val}
		node.Left = build()
		node.Right = build()
		return node
	}
	return build()
}

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}