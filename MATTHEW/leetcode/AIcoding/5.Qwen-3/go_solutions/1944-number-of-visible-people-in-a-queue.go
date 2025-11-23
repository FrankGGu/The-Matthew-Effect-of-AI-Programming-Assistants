package main

func canSeePersonsThatCanSeePerson(p []int) []int {
    n := len(p)
    res := make([]int, n)
    stack := make([]int, 0)

    for i := n - 1; i >= 0; i-- {
        count := 0
        for len(stack) > 0 && p[stack[len(stack)-1]] < p[i] {
            stack = stack[:len(stack)-1]
            count++
        }
        if len(stack) > 0 {
            count++
        }
        res[i] = count
        stack = append(stack, i)
    }

    return res
}