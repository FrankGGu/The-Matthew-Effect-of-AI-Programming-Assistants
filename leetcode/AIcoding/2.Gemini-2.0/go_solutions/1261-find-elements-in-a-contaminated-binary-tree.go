type FindElements struct {
    root *TreeNode
    seen map[int]bool
}

type TreeNode struct {
    Val int
    Left *TreeNode
    Right *TreeNode
}

func Constructor(root *TreeNode) FindElements {
    root.Val = 0
    queue := []*TreeNode{root}
    seen := make(map[int]bool)
    seen[0] = true

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]

        if node.Left != nil {
            node.Left.Val = 2*node.Val + 1
            seen[node.Left.Val] = true
            queue = append(queue, node.Left)
        }
        if node.Right != nil {
            node.Right.Val = 2*node.Val + 2
            seen[node.Right.Val] = true
            queue = append(queue, node.Right)
        }
    }

    return FindElements{root: root, seen: seen}
}

func (this *FindElements) Find(target int) bool {
    return this.seen[target]
}