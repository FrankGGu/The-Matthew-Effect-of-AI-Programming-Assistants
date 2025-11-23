package main

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

func (c *Codec) serialize(root *TreeNode) string {
	var res []string
	var dfs func(*TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			res = append(res, "nil")
			return
		}
		res = append(res, strconv.Itoa(node.Val))
		dfs(node.Left)
		dfs(node.Right)
	}
	dfs(root)
	return strings.Join(res, ",")
}

func (c *Codec) deserialize(data string) *TreeNode {
	nodes := strings.Split(data, ",")
	var i int
	var build func() *TreeNode
	build = func() *TreeNode {
		if i >= len(nodes) {
			return nil
		}
		if nodes[i] == "nil" {
			i++
			return nil
		}
		val, _ := strconv.Atoi(nodes[i])
		i++
		return &TreeNode{Val: val, Left: build(), Right: build()}
	}
	return build()
}