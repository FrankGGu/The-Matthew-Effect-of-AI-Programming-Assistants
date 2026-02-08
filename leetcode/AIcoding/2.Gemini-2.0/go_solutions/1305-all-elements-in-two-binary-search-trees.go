type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func getAllElements(root1 *TreeNode, root2 *TreeNode) []int {
	nums1 := inorderTraversal(root1)
	nums2 := inorderTraversal(root2)
	return merge(nums1, nums2)
}

func inorderTraversal(root *TreeNode) []int {
	result := []int{}
	var inorder func(*TreeNode)
	inorder = func(node *TreeNode) {
		if node == nil {
			return
		}
		inorder(node.Left)
		result = append(result, node.Val)
		inorder(node.Right)
	}
	inorder(root)
	return result
}

func merge(nums1 []int, nums2 []int) []int {
	result := []int{}
	i, j := 0, 0
	for i < len(nums1) && j < len(nums2) {
		if nums1[i] < nums2[j] {
			result = append(result, nums1[i])
			i++
		} else {
			result = append(result, nums2[j])
			j++
		}
	}
	for i < len(nums1) {
		result = append(result, nums1[i])
		i++
	}
	for j < len(nums2) {
		result = append(result, nums2[j])
		j++
	}
	return result
}