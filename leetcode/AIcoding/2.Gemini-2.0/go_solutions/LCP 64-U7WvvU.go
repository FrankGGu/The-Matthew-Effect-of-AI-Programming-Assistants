type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func lightUp(root *TreeNode) int {
	if root == nil {
		return 0
	}
	res := 0
	covered := make(map[*TreeNode]bool)
	var dfs func(node *TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			return
		}
		dfs(node.Left)
		dfs(node.Right)

		if !covered[node] && (node.Left == nil || !covered[node.Left]) && (node.Right == nil || !covered[node.Right]) {
			res++
			covered[node] = true
			if node.Left != nil {
				covered[node.Left] = true
			}
			if node.Right != nil {
				covered[node.Right] = true
			}
			if getParent(root, node) != nil {
				covered[getParent(root, node)] = true
			} else {
				covered[node] = true //root node is covered
			}
		}
	}

	dfs(root)

	uncovered := false
	var checkCovered func(node *TreeNode)
	checkCovered = func(node *TreeNode) {
		if node == nil {
			return
		}
		if !covered[node] {
			uncovered = true
		}
		checkCovered(node.Left)
		checkCovered(node.Right)
	}
	checkCovered(root)

	if uncovered {
		res++
	}

	return res
}

func getParent(root *TreeNode, node *TreeNode) *TreeNode {
	if root == nil || node == root {
		return nil
	}
	var parent *TreeNode
	var dfs func(curr *TreeNode)
	dfs = func(curr *TreeNode) {
		if curr == nil {
			return
		}
		if curr.Left == node || curr.Right == node {
			parent = curr
			return
		}
		dfs(curr.Left)
		dfs(curr.Right)
	}
	dfs(root)
	return parent
}