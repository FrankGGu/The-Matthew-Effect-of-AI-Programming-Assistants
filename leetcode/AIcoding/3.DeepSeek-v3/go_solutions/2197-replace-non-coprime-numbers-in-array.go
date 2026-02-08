func replaceNonCoprimes(nums []int) []int {
    stack := []int{}
    for _, num := range nums {
        current := num
        for len(stack) > 0 {
            last := stack[len(stack)-1]
            gcdVal := gcd(last, current)
            if gcdVal == 1 {
                break
            }
            stack = stack[:len(stack)-1]
            current = current * last / gcdVal
        }
        stack = append(stack, current)
    }
    return stack
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}