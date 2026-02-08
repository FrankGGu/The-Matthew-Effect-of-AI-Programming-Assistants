type NestedInteger struct {
}

func (n NestedInteger) IsInteger() bool {
	panic("not implemented")
}

func (n NestedInteger) GetInteger() int {
	panic("not implemented")
}

func (n NestedInteger) GetList() []*NestedInteger {
	panic("not implemented")
}

type NestedIterator struct {
	stack []*NestedInteger
}

func Constructor(nestedList []*NestedInteger) *NestedIterator {
	stack := make([]*NestedInteger, 0)
	for i := len(nestedList) - 1; i >= 0; i-- {
		stack = append(stack, nestedList[i])
	}
	return &NestedIterator{stack: stack}
}

func (this *NestedIterator) Next() int {
	val := this.stack[len(this.stack)-1].GetInteger()
	this.stack = this.stack[:len(this.stack)-1]
	return val
}

func (this *NestedIterator) HasNext() bool {
	for len(this.stack) > 0 {
		top := this.stack[len(this.stack)-1]
		if top.IsInteger() {
			return true
		}
		this.stack = this.stack[:len(this.stack)-1]
		list := top.GetList()
		for i := len(list) - 1; i >= 0; i-- {
			this.stack = append(this.stack, list[i])
		}
	}
	return false
}