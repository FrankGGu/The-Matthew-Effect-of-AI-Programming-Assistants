package main


type ListNode struct {
	Val  int
	next *ListNode
}

func deleteNodes(head *ListNode, nums []int) *ListNode {
	set := make(map[int]bool)
	for _, num := range nums {
		set[num] = true
	}

	dummy := &ListNode{}
	dummy.next = head
	current := dummy

	for current.next != nil {
		if set[current.next.Val] {
			current.next = current.next.next
		} else {
			current = current.next
		}
	}

	return dummy.next
}