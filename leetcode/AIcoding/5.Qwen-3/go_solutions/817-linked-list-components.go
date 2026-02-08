package main


func isPresent(set map[int]bool, val int) bool {
    _, found := set[val]
    return found
}

func numComponents(head *ListNode, nums []int) int {
    set := make(map[int]bool)
    for _, num := range nums {
        set[num] = true
    }
    count := 0
    current := head
    for current != nil {
        if isPresent(set, current.Val) {
            count++
            for current != nil && isPresent(set, current.Val) {
                current = current.Next
            }
        } else {
            current = current.Next
        }
    }
    return count
}