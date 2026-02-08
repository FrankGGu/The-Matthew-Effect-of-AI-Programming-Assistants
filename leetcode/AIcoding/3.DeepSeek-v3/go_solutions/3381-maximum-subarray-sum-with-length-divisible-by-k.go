func maxSubarraySumCircular(nums []int, k int) int {
    n := len(nums)
    prefixSum := make([]int, 2*n+1)
    for i := 0; i < 2*n; i++ {
        prefixSum[i+1] = prefixSum[i] + nums[i%n]
    }

    res := -1 << 31
    deque := make([]int, 0)
    for i := 0; i <= 2*n; i++ {
        for len(deque) > 0 && i - deque[0] > k {
            deque = deque[1:]
        }
        if len(deque) > 0 {
            sum := prefixSum[i] - prefixSum[deque[0]]
            if sum > res {
                res = sum
            }
        }
        for len(deque) > 0 && prefixSum[i] <= prefixSum[deque[len(deque)-1]] {
            deque = deque[:len(deque)-1]
        }
        deque = append(deque, i)
    }
    return res
}