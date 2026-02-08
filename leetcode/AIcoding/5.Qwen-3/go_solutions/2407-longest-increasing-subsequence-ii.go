package main

func lengthOfLIS(nums []int, k int) int {
    type Node struct {
        left  *Node
        right *Node
        val   int
    }
    root := &Node{val: nums[0]}
    maxLen := 1
    for i := 1; i < len(nums); i++ {
        current := nums[i]
        node := root
        prev := node
        var parent *Node
        for node != nil {
            if current < node.val {
                parent = node
                node = node.left
            } else if current > node.val {
                parent = node
                node = node.right
            } else {
                break
            }
        }
        if parent == nil {
            if current < root.val {
                root.left = &Node{val: current}
            } else {
                root.right = &Node{val: current}
            }
        } else {
            if current < parent.val {
                parent.left = &Node{val: current}
            } else {
                parent.right = &Node{val: current}
            }
        }
        count := 1
        node = root
        for node != nil {
            if current < node.val {
                node = node.left
                count++
            } else if current > node.val {
                node = node.right
                count++
            } else {
                break
            }
        }
        if count > maxLen {
            maxLen = count
        }
    }
    return maxLen
}