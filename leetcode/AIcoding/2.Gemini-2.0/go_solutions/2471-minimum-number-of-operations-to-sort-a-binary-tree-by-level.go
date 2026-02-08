import "container/list"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func minimumOperations(root *TreeNode) int {
	if root == nil {
		return 0
	}

	q := list.New()
	q.PushBack(root)

	operations := 0
	for q.Len() > 0 {
		levelSize := q.Len()
		levelValues := make([]int, 0, levelSize)

		for i := 0; i < levelSize; i++ {
			node := q.Remove(q.Front()).(*TreeNode)
			levelValues = append(levelValues, node.Val)

			if node.Left != nil {
				q.PushBack(node.Left)
			}
			if node.Right != nil {
				q.PushBack(node.Right)
			}
		}

		operations += countSwaps(levelValues)
	}

	return operations
}

func countSwaps(arr []int) int {
	n := len(arr)
	pos := make(map[int]int)
	for i := 0; i < n; i++ {
		pos[arr[i]] = i
	}

	sortedArr := make([]int, n)
	copy(sortedArr, arr)
	sort.Ints(sortedArr)

	swaps := 0
	visited := make([]bool, n)

	for i := 0; i < n; i++ {
		if visited[i] || arr[i] == sortedArr[i] {
			continue
		}

		cycleSize := 0
		j := i
		for !visited[j] {
			visited[j] = true
			j = pos[sortedArr[j]]
			cycleSize++
		}

		if cycleSize > 0 {
			swaps += (cycleSize - 1)
		}
	}

	return swaps
}

import "sort"