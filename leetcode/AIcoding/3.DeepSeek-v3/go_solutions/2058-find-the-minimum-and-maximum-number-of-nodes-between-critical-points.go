/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func nodesBetweenCriticalPoints(head *ListNode) []int {
    if head == nil || head.Next == nil || head.Next.Next == nil {
        return []int{-1, -1}
    }

    prev := head
    curr := head.Next
    next := curr.Next
    positions := []int{}
    index := 1

    for next != nil {
        if (curr.Val > prev.Val && curr.Val > next.Val) || (curr.Val < prev.Val && curr.Val < next.Val) {
            positions = append(positions, index)
        }
        prev = curr
        curr = next
        next = next.Next
        index++
    }

    if len(positions) < 2 {
        return []int{-1, -1}
    }

    minDist := math.MaxInt32
    for i := 1; i < len(positions); i++ {
        dist := positions[i] - positions[i-1]
        if dist < minDist {
            minDist = dist
        }
    }

    maxDist := positions[len(positions)-1] - positions[0]

    return []int{minDist, maxDist}
}