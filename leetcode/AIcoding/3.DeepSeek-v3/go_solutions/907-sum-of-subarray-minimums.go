func sumSubarrayMins(arr []int) int {
    const mod = 1e9 + 7
    n := len(arr)
    left := make([]int, n)
    right := make([]int, n)
    stack := []int{}

    for i := 0; i < n; i++ {
        for len(stack) > 0 && arr[stack[len(stack)-1]] > arr[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            left[i] = -1
        } else {
            left[i] = stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    stack = []int{}
    for i := n - 1; i >= 0; i-- {
        for len(stack) > 0 && arr[stack[len(stack)-1]] >= arr[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            right[i] = n
        } else {
            right[i] = stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    res := 0
    for i := 0; i < n; i++ {
        res = (res + arr[i] * (i - left[i]) * (right[i] - i)) % mod
    }
    return res
}