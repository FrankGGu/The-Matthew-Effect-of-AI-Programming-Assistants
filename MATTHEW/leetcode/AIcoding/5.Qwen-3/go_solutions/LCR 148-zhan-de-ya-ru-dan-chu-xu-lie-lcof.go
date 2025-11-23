package main

func validateBookOrder(putIn []int, takeOut []int) bool {
    stack := []int{}
    i := 0
    for _, num := range putIn {
        stack = append(stack, num)
        for len(stack) > 0 && stack[len(stack)-1] == takeOut[i] {
            stack = stack[:len(stack)-1]
            i++
        }
    }
    return i == len(takeOut)
}