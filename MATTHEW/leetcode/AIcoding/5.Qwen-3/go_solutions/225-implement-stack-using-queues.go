package main

type MyStack struct {
    q1 []int
    q2 []int
}

func Constructor() MyStack {
    return MyStack{
        q1: make([]int, 0),
        q2: make([]int, 0),
    }
}

func (this *MyStack) push(x int) {
    this.q2 = append(this.q2, x)
    for len(this.q1) > 0 {
        this.q2 = append(this.q2, this.q1[0])
        this.q1 = this.q1[1:]
    }
    this.q1, this.q2 = this.q2, this.q1
}

func (this *MyStack) pop() int {
    if len(this.q1) == 0 {
        return -1
    }
    val := this.q1[0]
    this.q1 = this.q1[1:]
    return val
}

func (this *MyStack) top() int {
    if len(this.q1) == 0 {
        return -1
    }
    return this.q1[0]
}

func (this *MyStack) empty() bool {
    return len(this.q1) == 0
}