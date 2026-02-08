package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func checkPalindromeDFSStrings(root *TreeNode) int {
	count := 0

	isPalindrome := func(s []byte) bool {
		left, right := 0, len(s)-1
		for left < right {
			if s[left] != s[right] {
				return false
			}
			left++
			right--
		}
		return true
	}

	var dfs func(node *TreeNode, currentPath []byte)
	dfs = func(node *TreeNode, currentPath []byte) {
		if node == nil {
			return
		}

		nextPath := make([]byte, len(currentPath)+1)
		copy(nextPath, currentPath)
		nextPath[len(currentPath)] = byte(node.Val)

		if node.Left == nil && node.Right == nil {
			if isPalindrome(nextPath) {
				count++
			}
			return
		}

		dfs(node.Left, nextPath)
		dfs(node.Right, nextPath)
	}

	dfs(root, []byte{})
	return count
}