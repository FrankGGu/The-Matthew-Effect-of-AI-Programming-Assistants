import (
	"math/rand"
)

type ListNode struct {
	Val  int
	Next *ListNode
}

type Solution struct {
	head *ListNode
}

func Constructor(head *ListNode) Solution {
	return Solution{head: head}
}

func (this *Solution) GetRandom() int {
	scope := 1
	chosenValue := this.head.Val
	curr := this.head.Next

	for curr != nil {
		if rand.Intn(scope+1) == scope {
			chosenValue = curr.Val
		}
		scope++
		curr = curr.Next
	}

	return chosenValue
}