/**
 * Definition for a Node.
 * type Node struct {
 *     Val int
 *     Next *Node
 * }
 */

func insert(aNode *Node, x int) *Node {
    newNode := &Node{Val: x}
    if aNode == nil {
        newNode.Next = newNode
        return newNode
    }

    prev, curr := aNode, aNode.Next
    toInsert := false

    for {
        if (prev.Val <= x && x <= curr.Val) || 
           (prev.Val > curr.Val && (x >= prev.Val || x <= curr.Val)) {
            toInsert = true
        } else if curr == aNode {
            break
        }

        if toInsert {
            break
        }

        prev, curr = curr, curr.Next
    }

    prev.Next = newNode
    newNode.Next = curr

    return aNode
}