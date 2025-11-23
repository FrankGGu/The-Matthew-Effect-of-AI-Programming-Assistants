/**
 * Definition for a Node.
 * type Node struct {
 *     Val int
 *     Prev *Node
 *     Next *Node
 *     Child *Node
 * }
 */

func flatten(root *Node) *Node {
    if root == nil {
        return nil
    }
    dummy := &Node{Val: 0, Prev: nil, Next: root, Child: nil}
    flattenDFS(dummy, root)
    dummy.Next.Prev = nil
    return dummy.Next
}

func flattenDFS(prev, curr *Node) *Node {
    if curr == nil {
        return prev
    }
    curr.Prev = prev
    prev.Next = curr

    next := curr.Next
    tail := flattenDFS(curr, curr.Child)
    curr.Child = nil
    return flattenDFS(tail, next)
}