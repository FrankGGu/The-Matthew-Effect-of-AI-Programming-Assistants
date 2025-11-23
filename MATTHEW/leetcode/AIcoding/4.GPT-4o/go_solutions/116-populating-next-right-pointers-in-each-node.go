package main

// Definition for a Node.
type Node struct {
	Val      int
	Left     *Node
	Right    *Node
	Next     *Node
}

func connect(root *Node) *Node {
    if root == nil {
        return nil
    }

    leftmost := root

    for leftmost.Left != nil {
        head := leftmost

        for head != nil {
            head.Left.Next = head.Right

            if head.Next != nil {
                head.Right.Next = head.Next.Left
            }

            head = head.Next
        }

        leftmost = leftmost.Left
    }

    return root
}