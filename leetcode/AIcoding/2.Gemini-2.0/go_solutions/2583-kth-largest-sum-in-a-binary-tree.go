import "container/list"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func kthLargestLevelSum(root *TreeNode, k int) int {
	if root == nil {
		return -1
	}

	sums := []int{}
	queue := list.New()
	queue.PushBack(root)

	for queue.Len() > 0 {
		levelSize := queue.Len()
		levelSum := 0
		for i := 0; i < levelSize; i++ {
			node := queue.Front()
			queue.Remove(node)
			curr := node.Value.(*TreeNode)
			levelSum += curr.Val

			if curr.Left != nil {
				queue.PushBack(curr.Left)
			}
			if curr.Right != nil {
				queue.PushBack(curr.Right)
			}
		}
		sums = append(sums, levelSum)
	}

	if len(sums) < k {
		return -1
	}

	sortDesc(sums)

	return sums[k-1]
}

func sortDesc(arr []int) {
	for i := 0; i < len(arr); i++ {
		for j := i + 1; j < len(arr); j++ {
			if arr[i] < arr[j] {
				arr[i], arr[j] = arr[j], arr[i]
			}
		}
	}
}