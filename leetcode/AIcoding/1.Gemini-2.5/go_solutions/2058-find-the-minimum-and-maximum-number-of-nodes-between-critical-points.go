import "math"

func nodesBetweenCriticalPoints(head *ListNode) []int {
    if head == nil || head.Next == nil || head.Next.Next == nil {
        return []int{-1, -1}
    }

    criticalPointsIndices := []int{}

    prev := head
    curr := head.Next
    pointIndex := 1 // 1-based index for the current node (curr)

    for curr.Next != nil {
        next := curr.Next

        isCritical := false
        if (curr.Val > prev.Val && curr.Val > next.Val) || (curr.Val < prev.Val && curr.Val < next.Val) {
            isCritical = true
        }

        if isCritical {
            criticalPointsIndices = append(criticalPointsIndices, pointIndex)
        }

        prev = curr
        curr = next
        pointIndex++
    }

    if len(criticalPointsIndices) < 2 {
        return []int{-1, -1}
    }

    minDistance := math.MaxInt32
    maxDistance := criticalPointsIndices[len(criticalPointsIndices)-1] - criticalPointsIndices[0]

    for i := 0; i < len(criticalPointsIndices)-1; i++ {
        diff := criticalPointsIndices[i+1] - criticalPointsIndices[i]
        if diff < minDistance {
            minDistance = diff
        }
    }

    return []int{minDistance, maxDistance}
}