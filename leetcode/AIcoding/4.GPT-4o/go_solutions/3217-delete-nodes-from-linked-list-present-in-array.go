package main

type ListNode struct {
	Val  int
	Next *ListNode
}

func deleteNodes(head *ListNode, toDelete []int) *ListNode {
	deleteMap := make(map[int]struct{})
	for _, val := range toDelete {
		deleteMap[val] = struct{}{}
	}

	dummy := &ListNode{Next: head}
	current := dummy

	for current.Next != nil {
		if _, found := deleteMap[current.Next.Val]; found {
			current.Next = current.Next.Next
		} else {
			current = current.Next
		}
	}

	return dummy.Next
}