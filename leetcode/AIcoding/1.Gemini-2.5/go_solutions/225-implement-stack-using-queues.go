import "container/list"

type MyStack struct {
	q1 *list.List
	q2 *list.List
}

func Constructor() MyStack {
	return MyStack{
		q1: list.New(),
		q2: list.New(),
	}
}

func (this *MyStack