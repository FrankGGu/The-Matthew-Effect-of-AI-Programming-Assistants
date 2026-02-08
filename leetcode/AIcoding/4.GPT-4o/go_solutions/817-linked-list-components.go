type ListNode struct {
    Val  int
    Next *ListNode
}

func numComponents(head *ListNode, G []int) int {
    set := make(map[int]struct{})
    for _, v := range G {
        set[v] = struct{}{}
    }

    count := 0
    inComponent := false

    for head != nil {
        if _, exists := set[head.Val]; exists {
            if !inComponent {
                count++
                inComponent = true
            }
        } else {
            inComponent = false
        }
        head = head.Next
    }

    return count
}