func maximumScore(nums []int, k int) int {
    n := len(nums)
    left := make([]int, n)
    right := make([]int, n)
    stack := []int{}

    for i := 0; i < n; i++ {
        for len(stack) > 0 && nums[stack[len(stack)-1]] < nums[i] {
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
        for len(stack) > 0 && nums[stack[len(stack)-1]] <= nums[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            right[i] = n
        } else {
            right[i] = stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    type pair struct {
        val   int
        count int
    }
    arr := make([]pair, n)
    for i := 0; i < n; i++ {
        arr[i] = pair{nums[i], (i - left[i]) * (right[i] - i)}
    }

    sort.Slice(arr, func(i, j int) bool {
        return arr[i].val > arr[j].val
    })

    res := 1
    mod := int(1e9 + 7)
    for i := 0; i < n && k > 0; i++ {
        take := min(arr[i].count, k)
        res = (res * pow(arr[i].val, take, mod)) % mod
        k -= take
    }

    return res
}

func pow(a, b, mod int) int {
    res := 1
    for b > 0 {
        if b&1 == 1 {
            res = (res * a) % mod
        }
        a = (a * a) % mod
        b >>= 1
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}