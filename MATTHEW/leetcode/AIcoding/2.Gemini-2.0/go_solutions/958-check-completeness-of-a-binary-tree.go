import "container/list"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func isCompleteTree(root *TreeNode) bool {
	if root == nil {
		return true
	}

	queue := list.New()
	queue.PushBack(root)
	flag := false

	for queue.Len() > 0 {
		node := queue.Remove(queue.Front()).(*TreeNode)

		if node == nil {
			flag = true
		} else {
			if flag {
				return false
			}
			queue.PushBack(node.Left)
			queue.PushBack(node.Right)
		}
	}

	return true
}