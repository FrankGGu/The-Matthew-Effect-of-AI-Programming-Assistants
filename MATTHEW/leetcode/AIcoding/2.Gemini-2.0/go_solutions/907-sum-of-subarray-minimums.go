func sumSubarrayMins(arr []int) int {
    n := len(arr)
    left := make([]int, n)
    right := make([]int, n)
    stack := []int{}

    for i := 0; i < n; i++ {
        for len(stack) > 0 && arr[stack[len(stack)-1]] > arr[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            left[i] = i + 1
        } else {
            left[i] = i - stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    stack = []int{}
    for i := n - 1; i >= 0; i-- {
        for len(stack) > 0 && arr[stack[len(stack)-1]] >= arr[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            right[i] = n - i
        } else {
            right[i] = stack[len(stack)-1] - i
        }
        stack = append(stack, i)
    }

    result := 0
    mod := 1000000007
    for i := 0; i < n; i++ {
        result = (result + arr[i]*left[i]*right[i]) % mod
    }

    return result
}