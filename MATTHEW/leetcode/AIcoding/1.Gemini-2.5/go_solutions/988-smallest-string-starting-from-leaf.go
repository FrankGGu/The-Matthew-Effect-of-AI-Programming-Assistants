func dfs(node *TreeNode, currentPath []byte, minStr *string) {
	if node == nil {
		return
	}

	currentPath = append(currentPath, byte('a'+node.Val))

	if node.Left == nil && node.Right == nil {
		leafToRootStr := make([]byte, len(currentPath))
		for i := 0; i < len(currentPath); i++ {
			leafToRootStr[i] = currentPath[len(currentPath)-1-i]
		}
		s := string(leafToRootStr)

		if *minStr == "" || s < *minStr {
			*minStr = s
		}
	} else {
		dfs(node.Left, currentPath, minStr)
		dfs(node.Right, currentPath, minStr)
	}
}

func smallestFromLeaf(root *TreeNode) string {
	var minStr string
	dfs(root, []byte{}, &minStr)
	return minStr
}