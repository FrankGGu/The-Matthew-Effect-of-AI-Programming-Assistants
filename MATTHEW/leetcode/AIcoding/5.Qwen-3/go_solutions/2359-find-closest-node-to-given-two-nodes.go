package main


func closestNodeToGivenTwoNodes(head *ListNode, node1 int, node2 int) int {
    var find func(val int) int
    find = func(val int) int {
        idx := 0
        curr := head
        for curr != nil {
            if curr.Val == val {
                return idx
            }
            curr = curr.Next
            idx++
        }
        return -1
    }

    idx1 := find(node1)
    idx2 := find(node2)

    if idx1 == -1 || idx2 == -1 {
        return -1
    }

    minDist := math.MaxInt32
    closest := -1
    curr := head
    for i := 0; curr != nil; i++ {
        dist := abs(i - idx1) + abs(i - idx2)
        if dist < minDist {
            minDist = dist
            closest = curr.Val
        }
        curr = curr.Next
    }

    return closest
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}