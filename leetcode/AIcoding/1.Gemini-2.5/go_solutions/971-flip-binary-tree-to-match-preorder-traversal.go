var voyageIndex int
var flipsResult []int
var isMatchImpossible bool

func dfs(node *TreeNode, voyage []int) {
	if isMatchImpossible {
		return
	}
	if node == nil {
		return
	}

	if voyageIndex >= len(voyage) || node.Val != voyage[voyageIndex] {
		isMatchImpossible = true
		return
	}
	voyageIndex++

	if node.Left != nil && voyageIndex < len(voyage) && node.Left.Val != voyage[voyageIndex] {
		if node.Right != nil && voyageIndex < len(voyage) && node.Right.Val == voyage[voyageIndex] {
			flipsResult = append(flipsResult, node.Val)
			dfs(node.Right, voyage)
			dfs(node.Left, voyage)
		} else {
			isMatchImpossible = true
		}
	} else {
		dfs(node.Left, voyage)
		dfs(node.Right, voyage)
	}
}

func flipMatchVoyage(root *TreeNode, voyage []int) []int {
	voyageIndex = 0
	flipsResult = []int{}
	isMatchImpossible = false

	dfs(root, voyage)

	if isMatchImpossible {
		return []int{-1}
	}
	return flipsResult
}