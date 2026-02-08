package main

func maxInt(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func minInt(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func getMinOperations(arr []int) int {
    n := len(arr)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
    }

    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            if arr[j] < arr[i] {
                dp[i] = minInt(dp[i], dp[j]+1)
            }
        }
    }

    return n - dp[n-1]
}

func findTheArrayConcaterValue(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }
    if n == 1 {
        return nums[0]
    }

    res := 0
    for i := 0; i < n/2; i++ {
        res += nums[i] * int(math.Pow(10, float64(len(strconv.Itoa(nums[n-1-i]))))) + nums[n-1-i]
    }
    if n%2 == 1 {
        res += nums[n/2]
    }
    return res
}

func canMakeStrictlyIncreasing(arr []int) bool {
    for i := 1; i < len(arr); i++ {
        if arr[i] <= arr[i-1] {
            return false
        }
    }
    return true
}

func makeArrayStrictlyIncreasing(arr []int) int {
    n := len(arr)
    if n <= 1 {
        return 0
    }

    if canMakeStrictlyIncreasing(arr) {
        return 0
    }

    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
    }

    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            if arr[j] < arr[i] {
                dp[i] = minInt(dp[i], dp[j]+1)
            }
        }
    }

    return n - dp[n-1]
}