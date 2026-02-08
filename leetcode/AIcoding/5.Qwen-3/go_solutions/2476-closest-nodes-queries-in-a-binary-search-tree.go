package main


func closestNodes(root *TreeNode, queries []int) [][]int {
	var result [][]int
	var inorder []int
	inorderTraversal(root, &inorder)
	for _, q := range queries {
		left, right := findClosest(inorder, q)
		result = append(result, []int{left, right})
	}
	return result
}

func inorderTraversal(root *TreeNode, result *[]int) {
	if root == nil {
		return
	}
	inorderTraversal(root.Left, result)
	*result = append(*result, root.Val)
	inorderTraversal(root.Right, result)
}

func findClosest(arr []int, target int) (int, int) {
	left := -1
	right := -1
	l, r := 0, len(arr)-1
	for l <= r {
		mid := l + (r-l)/2
		if arr[mid] == target {
			left = arr[mid]
			right = arr[mid]
			return left, right
		} else if arr[mid] < target {
			l = mid + 1
		} else {
			r = mid - 1
		}
	}
	if l < len(arr) {
		right = arr[l]
	}
	if r >= 0 {
		left = arr[r]
	}
	return left, right
}