func totalStrength(strength []int) int {
    const mod = 1_000_000_007
    n := len(strength)
    prefix := make([]int64, n+1)
    for i := 1; i <= n; i++ {
        prefix[i] = (prefix[i-1] + int64(strength[i-1])) % mod
    }

    left := make([]int, n)
    right := make([]int, n)
    stack := []int{}

    for i := 0; i < n; i++ {
        for len(stack) > 0 && strength[stack[len(stack)-1]] >= strength[i] {
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
        for len(stack) > 0 && strength[stack[len(stack)-1]] > strength[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            right[i] = n
        } else {
            right[i] = stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    result := int64(0)
    for i := 0; i < n; i++ {
        L := left[i] + 1
        R := right[i] - 1
        total := (int64(i-L+1) * int64(R-i+1)) % mod
        result = (result + total*int64(strength[i])) % mod
    }

    return int(result)
}