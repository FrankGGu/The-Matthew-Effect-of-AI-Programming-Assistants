package main

func isPalindrome(s string) bool {
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

func dfs(node *TreeNode, path string, result *[]string) {
    if node == nil {
        return
    }
    path += fmt.Sprintf("%d", node.Val)
    if node.Left == nil && node.Right == nil {
        *result = append(*result, path)
        return
    }
    dfs(node.Left, path, result)
    dfs(node.Right, path, result)
}

func isPalindromePaths(root *TreeNode) bool {
    var paths []string
    dfs(root, "", &paths)
    for _, path := range paths {
        if !isPalindrome(path) {
            return false
        }
    }
    return true
}