import "sort"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

type FindElements struct {
    values map[int]struct{}
}

func Constructor(root *TreeNode) FindElements {
    fe := FindElements{values: make(map[int]struct{})}
    fe.recover(root, 0)
    return fe
}

func (fe *FindElements) recover(node *TreeNode, val int) {
    if node == nil {
        return
    }
    node.Val = val
    fe.values[val] = struct{}{}
    fe.recover(node.Left, 2*val+1)
    fe.recover(node.Right, 2*val+2)
}

func (fe *FindElements) Find(target int) bool {
    _, exists := fe.values[target]
    return exists
}