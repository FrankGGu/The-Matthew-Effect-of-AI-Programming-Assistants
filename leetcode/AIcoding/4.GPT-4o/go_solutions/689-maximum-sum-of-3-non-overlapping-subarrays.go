func maxSumOfThreeSubarrays(arr []int, k int) int {
    n := len(arr)
    if n < 3*k {
        return 0
    }

    sum := make([]int, n+1)
    for i := 1; i <= n; i++ {
        sum[i] = sum[i-1] + arr[i-1]
    }

    maxSum := make([]int, n+1)
    for i := k; i <= n; i++ {
        maxSum[i] = max(maxSum[i-1], sum[i]-sum[i-k])
    }

    maxTotal := 0
    ans := make([]int, 3)

    for j := 2*k; j <= n; j++ {
        for i := k; i <= j-k; i++ {
            currentSum := (sum[i]-sum[i-k]) + (sum[j]-sum[j-k]) + maxSum[i]
            if currentSum > maxTotal {
                maxTotal = currentSum
                ans[0], ans[1], ans[2] = maxIndex(maxSum, i-k), i-k, j-k
            }
        }
    }

    return maxTotal
}

func maxIndex(maxSum []int, idx int) int {
    return idx - len(maxSum) + 1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}