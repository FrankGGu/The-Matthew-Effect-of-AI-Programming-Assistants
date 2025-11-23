type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

type Tree struct {
    root *TreeNode
}

func Constructor(root *TreeNode) Tree {
    return Tree{root: root}
}

func (t *Tree) Insert(val int) {
    t.root = insert(t.root, val)
}

func insert(node *TreeNode, val int) *TreeNode {
    if node == nil {
        return &TreeNode{Val: val}
    }
    if val < node.Val {
        node.Left = insert(node.Left, val)
    } else {
        node.Right = insert(node.Right, val)
    }
    return node
}

func (t *Tree) Search(val int) bool {
    return search(t.root, val)
}

func search(node *TreeNode, val int) bool {
    if node == nil {
        return false
    }
    if node.Val == val {
        return true
    }
    if val < node.Val {
        return search(node.Left, val)
    }
    return search(node.Right, val)
}

func (t *Tree) Delete(val int) {
    t.root = deleteNode(t.root, val)
}

func deleteNode(node *TreeNode, val int) *TreeNode {
    if node == nil {
        return nil
    }
    if val < node.Val {
        node.Left = deleteNode(node.Left, val)
    } else if val > node.Val {
        node.Right = deleteNode(node.Right, val)
    } else {
        if node.Left == nil {
            return node.Right
        } else if node.Right == nil {
            return node.Left
        }
        minNode := findMin(node.Right)
        node.Val = minNode.Val
        node.Right = deleteNode(node.Right, minNode.Val)
    }
    return node
}

func findMin(node *TreeNode) *TreeNode {
    for node.Left != nil {
        node = node.Left
    }
    return node
}