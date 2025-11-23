package main


type ListNode struct {
    Val int
    Next *ListNode
}

func Constructor(head *ListNode) Solution {
    return Solution{head: head}
}

func (s *Solution) GetRandom() int {
    var result int
    node := s.head
    count := 0
    for node != nil {
        count++
        if rand.Intn(count) == 0 {
            result = node.Val
        }
        node = node.Next
    }
    return result
}

type Solution struct {
    head *ListNode
}