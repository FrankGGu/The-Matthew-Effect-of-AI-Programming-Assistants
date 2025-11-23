package main

func scoreOfParentheses(S string) int {
    stack := []int{}
    for _, c := range S {
        if c == '(' {
            stack = append(stack, 0)
        } else {
            top := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            if top == 0 {
                stack = append(stack, 1)
            } else {
                stack = append(stack, top*2)
            }
        }
    }
    return stack[0]
}