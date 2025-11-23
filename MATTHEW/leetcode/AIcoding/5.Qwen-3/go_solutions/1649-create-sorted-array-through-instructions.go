package main

func createSortedArray(instructions []int) int {
    type Node struct {
        left  *Node
        right *Node
        val   int
        cnt   int
    }

    root := &Node{}
    res := 0
    mod := 1000000007

    for _, ins := range instructions {
        curr := root
        for {
            curr.cnt++
            if ins < curr.val {
                if curr.left == nil {
                    curr.left = &Node{val: ins}
                    break
                }
                curr = curr.left
            } else if ins > curr.val {
                if curr.right == nil {
                    curr.right = &Node{val: ins}
                    break
                }
                curr = curr.right
            } else {
                break
            }
        }
    }

    var getRank func(*Node, int) int
    getRank = func(node *Node, val int) int {
        res := 0
        for node != nil {
            if val < node.val {
                node = node.left
            } else if val > node.val {
                res += node.cnt
                if node.left != nil {
                    res += node.left.cnt
                }
                node = node.right
            } else {
                if node.left != nil {
                    res += node.left.cnt
                }
                break
            }
        }
        return res
    }

    for _, ins := range instructions {
        res += getRank(root, ins)
        res %= mod
    }

    return res
}