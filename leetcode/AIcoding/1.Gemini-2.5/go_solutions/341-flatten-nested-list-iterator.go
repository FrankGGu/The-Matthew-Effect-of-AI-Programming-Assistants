type NestedIterator struct {
	stack []*NestedInteger
}

func Constructor(nestedList []*NestedInteger) *NestedIterator {
	s := make([]*NestedInteger, 0, len(nestedList))
	for i := len(nestedList) - 1; i >= 0; i-- {
		s = append(s, nestedList[i])
	}
	return &NestedIterator{stack: s}
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