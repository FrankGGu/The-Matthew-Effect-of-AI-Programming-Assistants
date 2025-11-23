func maxSumMinProduct(nums []int) int {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    left := make([]int, n)
    right := make([]int, n)
    stack := make([]int, 0)

    for i := 0; i < n; i++ {
        for len(stack) > 0 && nums[stack[len(stack)-1]] >= nums[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            left[i] = -1
        } else {
            left[i] = stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    stack = make([]int, 0)
    for i := n - 1; i >= 0; i-- {
        for len(stack) > 0 && nums[stack[len(stack)-1]] >= nums[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            right[i] = n
        } else {
            right[i] = stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    maxProduct := 0
    for i := 0; i < n; i++ {
        l := left[i] + 1
        r := right[i] - 1
        sum := prefix[r+1] - prefix[l]
        product := nums[i] * sum
        if product > maxProduct {
            maxProduct = product
        }
    }

    return maxProduct % (1e9 + 7)
}