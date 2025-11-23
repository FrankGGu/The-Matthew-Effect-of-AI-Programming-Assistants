package main


func removeZeroSumConsecutiveNodes(head *ListNode) *ListNode {
    dummy := &ListNode{0, head}
    current := dummy
    sumMap := make(map[int]*ListNode)
    sum := 0

    for current != nil {
        sum += current.Val
        if node, ok := sumMap[sum]; ok {
            current = node.Next
            sum = 0
            for current != nil {
                sum += current.Val
                if current != node.Next {
                    delete(sumMap, sum)
                }
                current = current.Next
            }
        } else {
            sumMap[sum] = current
            current = current.Next
        }
    }

    return dummy.Next
}