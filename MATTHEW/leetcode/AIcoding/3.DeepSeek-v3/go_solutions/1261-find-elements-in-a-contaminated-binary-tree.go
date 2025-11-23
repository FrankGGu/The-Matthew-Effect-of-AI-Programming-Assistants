/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
type FindElements struct {
    elements map[int]bool
}

func Constructor(root *TreeNode) FindElements {
    elements := make(map[int]bool)
    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, val int) {
        if node == nil {
            return
        }
        node.Val = val
        elements[val] = true
        dfs(node.Left, 2*val+1)
        dfs(node.Right, 2*val+2)
    }
    dfs(root, 0)
    return FindElements{elements: elements}
}

func (this *FindElements) Find(target int) bool {
    return this.elements[target]
}

/**
 * Your FindElements object will be instantiated and called as such:
 * obj := Constructor(root);
 * param_1 := obj.Find(target);
 */