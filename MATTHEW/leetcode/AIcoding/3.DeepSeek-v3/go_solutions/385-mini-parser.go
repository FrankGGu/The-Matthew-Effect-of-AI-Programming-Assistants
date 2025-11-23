/**
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * type NestedInteger struct {
 * }
 *
 * // Return true if this NestedInteger holds a single integer, rather than a nested list.
 * func (n NestedInteger) IsInteger() bool {}
 *
 * // Return the single integer that this NestedInteger holds, if it holds a single integer
 * // The result is undefined if this NestedInteger holds a nested list
 * // So before calling this method, you should have a check
 * func (n NestedInteger) GetInteger() int {}
 *
 * // Set this NestedInteger to hold a single integer.
 * func (n *NestedInteger) SetInteger(value int) {}
 *
 * // Set this NestedInteger to hold a nested list and adds a nested integer to it.
 * func (n *NestedInteger) Add(elem NestedInteger) {}
 *
 * // Return the nested list that this NestedInteger holds, if it holds a nested list
 * // The list is not empty if it holds a nested list
 * // So before calling this method, you should have a check
 * func (n NestedInteger) GetList() []*NestedInteger {}
 */

func deserialize(s string) *NestedInteger {
    if len(s) == 0 {
        return nil
    }
    if s[0] != '[' {
        num, _ := strconv.Atoi(s)
        ni := &NestedInteger{}
        ni.SetInteger(num)
        return ni
    }
    stack := []*NestedInteger{}
    var curr *NestedInteger
    start := 0
    for i := 0; i < len(s); i++ {
        if s[i] == '[' {
            if curr != nil {
                stack = append(stack, curr)
            }
            curr = &NestedInteger{}
            start = i + 1
        } else if s[i] == ']' || s[i] == ',' {
            if start < i {
                num, _ := strconv.Atoi(s[start:i])
                ni := &NestedInteger{}
                ni.SetInteger(num)
                curr.Add(*ni)
            }
            start = i + 1
            if s[i] == ']' && len(stack) > 0 {
                last := stack[len(stack)-1]
                stack = stack[:len(stack)-1]
                last.Add(*curr)
                curr = last
            }
        }
    }
    return curr
}