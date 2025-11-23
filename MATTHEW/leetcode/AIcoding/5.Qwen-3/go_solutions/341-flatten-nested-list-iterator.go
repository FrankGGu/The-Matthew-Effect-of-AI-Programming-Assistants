package main


type NestedInteger struct {
}

func (n NestedInteger) IsInteger() bool {
	return false
}

func (n NestedInteger) GetInteger() int {
	return 0
}

func (n NestedInteger) GetList() []NestedInteger {
	return nil
}

type NestedIterator struct {
	stack []int
}

func Constructor(nestedList []NestedInteger) *NestedIterator {
	var iter NestedIterator
	iter.flatten(nestedList)
	return &iter
}

func (this *NestedIterator) flatten(nestedList []NestedInteger) {
	for i := len(nestedList) - 1; i >= 0; i-- {
		if nestedList[i].IsInteger() {
			this.stack = append(this.stack, nestedList[i].GetInteger())
		} else {
			this.flatten(nestedList[i].GetList())
		}
	}
}

func (this *NestedIterator) Next() int {
	val := this.stack[0]
	this.stack = this.stack[1:]
	return val
}

func (this *NestedIterator) HasNext() bool {
	return len(this.stack) > 0
}