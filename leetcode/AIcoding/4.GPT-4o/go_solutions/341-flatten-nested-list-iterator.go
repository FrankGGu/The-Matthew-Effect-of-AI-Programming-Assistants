package main

type NestedInteger struct {
    // This is the interface that allows for creating nested lists.
    // You should not implement it, or speculate about its implementation
}

type NestedIterator struct {
    stack []NestedInteger
}

func Constructor(nestedList []NestedInteger) *NestedIterator {
    return &NestedIterator{stack: nestedList}
}

func (this *NestedIterator) Next() int {
    ni := this.stack[len(this.stack)-1]
    this.stack = this.stack[:len(this.stack)-1]
    return ni.GetInteger()
}

func (this *NestedIterator) HasNext() bool {
    for len(this.stack) > 0 {
        ni := this.stack[len(this.stack)-1]
        if ni.IsInteger() {
            return true
        }
        this.stack = this.stack[:len(this.stack)-1]
        this.stack = append(this.stack, ni.GetList()...)
    }
    return false
}