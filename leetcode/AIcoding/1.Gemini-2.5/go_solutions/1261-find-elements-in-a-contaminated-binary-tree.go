type FindElements struct {
    seenValues map[int]bool
}

func Constructor(root *TreeNode) FindElements {
    seen := make(map[int]bool)

    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, val int) {
        if node == nil {
            return
        }
        seen[val] = true
        dfs(node.Left, 2*val+1)
        dfs(node.Right, 2*val+2)
    }

    dfs(root, 0)
    return FindElements{seenValues: seen}
}

func (this *FindElements) Find(target int) bool {
    return this.seenValues[target]
}