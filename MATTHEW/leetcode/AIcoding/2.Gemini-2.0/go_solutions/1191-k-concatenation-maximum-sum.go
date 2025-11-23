func kConcatenationMaxSum(arr []int, k int) int {
    n := len(arr)
    maxSubarraySum := func(arr []int) int {
        maxSoFar := 0
        currentMax := 0
        for i := 0; i < len(arr); i++ {
            currentMax = max(arr[i], currentMax+arr[i])
            maxSoFar = max(maxSoFar, currentMax)
        }
        return maxSoFar
    }

    maxSubarraySumCircular := func(arr []int) int {
        n := len(arr)
        maxSoFar := maxSubarraySum(arr)
        arrSum := 0
        for i := 0; i < n; i++ {
            arrSum += arr[i]
            arr[i] = -arr[i]
        }
        maxCircular := arrSum + maxSubarraySum(arr)
        if maxCircular > maxSoFar && maxCircular != 0 {
            return maxCircular
        } else {
            return maxSoFar
        }
    }

    max := func(a, b int) int {
        if a > b {
            return a
        }
        return b
    }

    if k == 1 {
        return maxSubarraySum(arr)
    }

    sum := 0
    for _, num := range arr {
        sum += num
    }

    if sum > 0 {
        return max(maxSubarraySumCircular(arr), maxSubarraySum(arr)*2-maxSubarraySumCircular(arr)+sum*(k-2))
    } else {
        return maxSubarraySumCircular(arr)
    }
}