package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func findDuplicateSubtrees(root *TreeNode) []*TreeNode {
	var result []*TreeNode
	seen := map[string]int{}
	var serialize func(*TreeNode) string
	serialize = func(node *TreeNode) string {
		if node == nil {
			return "#"
		}
		key := strconv.Itoa(node.Val) + "," + serialize(node.Left) + "," + serialize(node.Right)
		seen[key]++
		if seen[key] == 2 {
			result = append(result, node)
		}
		return key
	}
	serialize(root)
	return result
}