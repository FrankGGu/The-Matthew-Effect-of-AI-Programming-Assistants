package main


type FindElements struct {
    set map[int]bool
}

func Constructor(root *TreeNode) FindElements {
    s := make(map[int]bool)
    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, val int) {
        if node == nil {
            return
        }
        s[val] = true
        dfs(node.Left, 2*val+1)
        dfs(node.Right, 2*val+2)
    }
    dfs(root, 0)
    return FindElements{s}
}

func (this *FindElements) Find(target int) bool {
    return this.set[target]
}