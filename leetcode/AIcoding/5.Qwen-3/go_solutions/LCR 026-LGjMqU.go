package main

type ListNode struct {
	Val  int
	next *ListNode
}

func reorderList(head *ListNode) {
	if head == nil || head.next == nil {
		return
	}

	// 找到中间节点
	slow, fast := head, head
	for fast != nil && fast.next != nil {
		slow = slow.next
		fast = fast.next.next
	}

	// 反转后半部分链表
	var prev *ListNode
	curr := slow
	for curr != nil {
		next := curr.next
		curr.next = prev
		prev = curr
		curr = next
	}

	// 合并两个链表
	first, second := head, prev
	for second.next != nil {
		nextFirst := first.next
		nextSecond := second.next

		first.next = second
		second.next = nextFirst

		first = nextFirst
		second = nextSecond
	}
}