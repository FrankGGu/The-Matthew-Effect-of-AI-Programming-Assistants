type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func getDirections(root *TreeNode, startValue int, destValue int) string {
	var startPath, destPath []byte

	var findPath func(*TreeNode, int, []byte) []byte
	findPath = func(node *TreeNode, target int, path []byte) []byte {
		if node == nil {
			return nil
		}
		if node.Val == target {
			return path
		}

		leftPath := findPath(node.Left, target, append(path, 'L'))
		if leftPath != nil {
			return leftPath
		}

		rightPath := findPath(node.Right, target, append(path, 'R'))
		if rightPath != nil {
			return rightPath
		}

		return nil
	}

	startPath = findPath(root, startValue, []byte{})
	destPath = findPath(root, destValue, []byte{})

	i, j := 0, 0
	for i < len(startPath) && j < len(destPath) && startPath[i] == destPath[j] {
		i++
		j++
	}

	upMoves := len(startPath) - i
	downMoves := destPath[j:]

	result := ""
	for k := 0; k < upMoves; k++ {
		result += "U"
	}
	result += string(downMoves)

	return result
}