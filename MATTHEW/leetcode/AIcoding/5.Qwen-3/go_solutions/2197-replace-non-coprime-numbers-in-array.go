package main

func replaceNonCoprimeNumbers(nums []int) []int {
    stack := []int{}
    for _, num := range nums {
        for len(stack) > 0 {
            a, b := stack[len(stack)-1], num
            if gcd(a, b) == 1 {
                break
            }
            num = a * b / gcd(a, b)
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, num)
    }
    return stack
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}