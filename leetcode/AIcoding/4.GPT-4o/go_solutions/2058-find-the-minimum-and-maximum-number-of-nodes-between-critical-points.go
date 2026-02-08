type ListNode struct {
    Val  int
    Next *ListNode
}

func nodesBetweenCriticalPoints(head *ListNode) []int {
    var criticalPoints []int
    index := 0
    prev := head
    cur := head.Next

    for cur != nil && cur.Next != nil {
        if (prev.Val < cur.Val && cur.Val > cur.Next.Val) || (prev.Val > cur.Val && cur.Val < cur.Next.Val) {
            criticalPoints = append(criticalPoints, index+1)
        }
        prev = cur
        cur = cur.Next
        index++
    }

    if len(criticalPoints) < 2 {
        return []int{-1, -1}
    }

    minDist := criticalPoints[len(criticalPoints)-1] - criticalPoints[0]
    maxDist := criticalPoints[len(criticalPoints)-1] - criticalPoints[1]

    for i := 1; i < len(criticalPoints)-1; i++ {
        dist := criticalPoints[i+1] - criticalPoints[i]
        if dist < minDist {
            minDist = dist
        }
    }

    return []int{minDist, maxDist}
}