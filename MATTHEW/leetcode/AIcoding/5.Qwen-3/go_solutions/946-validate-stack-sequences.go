package main

func validateStackSequences pushed []int, popped []int bool {
    stack := []int{}
    i := 0
    for _, val := range pushed {
        stack = append(stack, val)
        for len(stack) > 0 && stack[len(stack)-1] == popped[i] {
            stack = stack[:len(stack)-1]
            i++
        }
    }
    return i == len(popped)
}