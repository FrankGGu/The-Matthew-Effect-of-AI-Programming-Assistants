import "strconv"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func recoverFromPreorder(traversal string) *TreeNode {
	var (
		i     int
		dfs   func(depth int) *TreeNode
		count func(i int) int
	)

	count = func(i int) int {
		c := 0
		for i < len(traversal) && traversal[i] == '-' {
			c++
			i++
		}
		return c
	}

	dfs = func(depth int) *TreeNode {
		if i >= len(traversal) {
			return nil
		}
		d := count(i)
		if d != depth {
			return nil
		}

		i += d
		j := i
		for j < len(traversal) && traversal[j] >= '0' && traversal[j] <= '9' {
			j++
		}

		val, _ := strconv.Atoi(traversal[i:j])
		i = j

		node := &TreeNode{Val: val}
		node.Left = dfs(depth + 1)
		node.Right = dfs(depth + 1)

		return node
	}

	return dfs(0)
}