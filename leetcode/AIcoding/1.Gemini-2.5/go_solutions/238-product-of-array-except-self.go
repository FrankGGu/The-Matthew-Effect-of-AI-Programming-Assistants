func productExceptSelf(nums []int) []int {
    n := len(nums)
    answer := make([]int, n)

    // Calculate left products
    // answer[i] will contain the product of all elements to the left of i
    // For index 0, there are no elements to the left, so product is 1
    answer[0] = 1
    for i := 1; i < n; i++ {
        answer[i] = answer[i-1] * nums[i-1]
    }

    // Calculate right products and combine with left products
    // rightProduct will store the product of all elements to the right of the current index
    rightProduct := 1
    for i := n - 1; i >= 0; i-- {
        // For the current index i, answer[i] already has the left product
        // Multiply it by the right product calculated so far
        answer[i] = answer[i] * rightProduct
        // Update rightProduct for the next iteration (to the left)
        rightProduct = rightProduct * nums[i]
    }

    return answer
}