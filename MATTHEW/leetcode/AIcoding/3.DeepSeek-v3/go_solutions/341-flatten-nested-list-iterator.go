/**
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * type NestedInteger struct {
 * }
 *
 * // Return true if this NestedInteger holds a single integer, rather than a nested list.
 * func (this NestedInteger) IsInteger() bool {}
 *
 * // Return the single integer that this NestedInteger holds, if it holds a single integer
 * // The result is undefined if this NestedInteger holds a nested list
 * // So before calling this method, you should have a check
 * func (this NestedInteger) GetInteger() int {}
 *
 * // Set this NestedInteger to hold a single integer.
 * func (n *NestedInteger) SetInteger(value int) {}
 *
 * // Set this NestedInteger to hold a nested list and adds a nested integer to it.
 * func (this *NestedInteger) Add(elem NestedInteger) {}
 *
 * // Return the nested list that this NestedInteger holds, if it holds a nested list
 * // The result is undefined if this NestedInteger holds a single integer
 * // So before calling this method, you should have a check
 * func (this NestedInteger) GetList() []*NestedInteger {}
 */

type NestedIterator struct {
    stack [][]*NestedInteger
}

func Constructor(nestedList []*NestedInteger) *NestedIterator {
    return &NestedIterator{stack: [][]*NestedInteger{nestedList}}
}

func (this *NestedIterator) Next() int {
    top := this.stack[len(this.stack)-1]
    val := top[0].GetInteger()
    this.stack[len(this.stack)-1] = top[1:]
    return val
}

func (this *NestedIterator) HasNext() bool {
    for len(this.stack) > 0 {
        top := this.stack[len(this.stack)-1]
        if len(top) == 0 {
            this.stack = this.stack[:len(this.stack)-1]
            continue
        }
        first := top[0]
        if first.IsInteger() {
            return true
        }
        this.stack[len(this.stack)-1] = top[1:]
        this.stack = append(this.stack, first.GetList())
    }
    return false
}