type MyStack struct {
	q1 []int
	q2 []int
}

func Constructor() MyStack {
	return MyStack{
		q1: []int{},
		q2: []int{},
	}
}

func (this *MyStack) Push(x int) {
	this.q1 = append(this.q1, x)
}

func (this *MyStack) Pop() int {
	for len(this.q1) > 1 {
		this.q2 = append(this.q2, this.q1[0])
		this.q1 = this.q1[1:]
	}
	top := this.q1[0]
	this.q1 = this.q2
	this.q2 = []int{}
	return top
}

func (this *MyStack) Top() int {
	top := this.Pop()
	this.q1 = append(this.q1, top)
	return top
}

func (this *MyStack) Empty() bool {
	return len(this.q1) == 0
}