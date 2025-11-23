import "math/gcd"

func findGCD(arr []int) int {
    res := arr[0]
    for _, num := range arr {
        res = gcd(res, num)
    }
    return res
}

func replaceNonCoprimes(arr []int) []int {
    stack := []int{}
    for _, num := range arr {
        for len(stack) > 0 {
            num = gcd(stack[len(stack)-1], num)
            if num == 1 {
                break
            }
            stack = append(stack[:len(stack)-1])
        }
        stack = append(stack, num)
    }

    result := make([]int, len(stack))
    copy(result, stack)
    return result
}