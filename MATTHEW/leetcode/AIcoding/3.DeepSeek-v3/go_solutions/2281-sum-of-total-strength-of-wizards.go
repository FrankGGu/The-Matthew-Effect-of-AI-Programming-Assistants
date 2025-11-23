func totalStrength(strength []int) int {
    mod := int(1e9 + 7)
    n := len(strength)
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

    prefix := make([]int, n+2)
    for i := 0; i < n; i++ {
        prefix[i+1] = (prefix[i] + strength[i]) % mod
    }

    prefixPrefix := make([]int, n+2)
    for i := 0; i < n; i++ {
        prefixPrefix[i+1] = (prefixPrefix[i] + prefix[i+1]) % mod
    }

    res := 0
    for i := 0; i < n; i++ {
        l := left[i] + 1
        r := right[i] - 1
        sumLeft := (prefixPrefix[i+1] - prefixPrefix[l] + mod) % mod
        sumLeft = sumLeft * (r - i + 1) % mod
        sumRight := (prefixPrefix[r+1] - prefixPrefix[i+1] + mod) % mod
        sumRight = sumRight * (i - l + 1) % mod
        total := (sumLeft - sumRight + mod) % mod
        res = (res + total * strength[i] % mod) % mod
    }
    return res
}