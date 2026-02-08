package main

import "math"

type ListNode struct {
	Val int
	Next *ListNode
}

func pairSum(head *ListNode) int {
	values := []int{}
	curr := head
	for curr != nil {
		values = append(values, curr.Val)
		curr = curr.Next
	}

	n := len(values)
	maxSum := 0

	for i := 0; i < n/2; i++ {
		currentSum := values[i] + values[n-1-i]
		if currentSum > maxSum {
			maxSum = currentSum
		}
	}

	return maxSum
}