type ListNode struct {
	Val  int
	Next *ListNode
}

type Solution struct {
	nodes   []int
	randGen *rand.Rand
}

func Constructor(head *ListNode)