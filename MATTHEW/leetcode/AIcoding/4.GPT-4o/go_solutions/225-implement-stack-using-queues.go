type MyStack struct {
    q1, q2 *queue
}

type queue struct {
    data []int
}

func (q *queue) push(x int) {
    q.data = append(q.data, x)
}

func (q *queue) pop() int {
    res := q.data[0]
    q.data = q.data[1:]
    return res
}

func (q *queue) size() int {
    return len(q.data)
}

func Constructor() MyStack {
    return MyStack{
        q1: &queue{},
        q2: &queue{},
    }
}

func (this *MyStack) Push(x int) {
    this.q1.push(x)
}

func (this *MyStack) Pop() int {
    for this.q1.size() > 1 {
        this.q2.push(this.q1.pop())
    }
    res := this.q1.pop()
    this.q1, this.q2 = this.q2, this.q1
    return res
}

func (this *MyStack) Top() int {
    for this.q1.size() > 1 {
        this.q2.push(this.q1.pop())
    }
    res := this.q1.pop()
    this.q2.push(res)
    this.q1, this.q2 = this.q2, this.q1
    return res
}

func (this *MyStack) Empty() bool {
    return this.q1.size() == 0
}