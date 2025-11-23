package main

func countVisitedNodes(head *ListNode) []int {
    n := 0
    curr := head
    for curr != nil {
        n++
        curr = curr.Next
    }

    visited := make([]bool, n)
    result := make([]int, n)

    for i := 0; i < n; i++ {
        if !visited[i] {
            path := []int{}
            node := head
            for j := 0; j <= i; j++ {
                node = node.Next
            }
            for node != nil && !visited[node.Val] {
                path = append(path, node.Val)
                visited[node.Val] = true
                node = node.Next
            }

            for k := len(path) - 1; k >= 0; k-- {
                result[path[k]] = len(path) - k
            }
        }
    }

    return result
}