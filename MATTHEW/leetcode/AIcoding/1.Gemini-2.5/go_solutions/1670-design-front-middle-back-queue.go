type Node struct {
	val  int
	prev *Node
	next *Node
}

type FrontMiddleBackQueue struct {
	head *Node // dummy head
	tail *Node // dummy tail
	size int
}

func Constructor() FrontMiddleBackQueue {
	head := &Node{}
	tail := &Node{}