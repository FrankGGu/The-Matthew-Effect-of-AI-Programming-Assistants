func kConcatenationMaxSum(arr []int, k int) int {
    const mod = 1e9 + 7
    maxSubarray := kadane(arr)
    if k == 1 {
        return maxSubarray % mod
    }

    sum := 0
    for _, num := range arr {
        sum += num
    }

    prefixMax := 0
    currentPrefix := 0
    for i := 0; i < len(arr); i++ {
        currentPrefix += arr[i]
        if currentPrefix > prefixMax {
            prefixMax = currentPrefix
        }
    }

    suffixMax := 0
    currentSuffix := 0
    for i := len(arr) - 1; i >= 0; i-- {
        currentSuffix += arr[i]
        if currentSuffix > suffixMax {
            suffixMax = currentSuffix
        }
    }

    maxKadane := kadane(append(arr, arr...))
    if sum > 0 {
        candidate := suffixMax + prefixMax + (k-2)*sum
        if candidate > maxKadane {
            maxKadane = candidate
        }
    }

    if maxKadane < 0 {
        return 0
    }
    return maxKadane % mod
}

func kadane(arr []int) int {
    maxEndingHere, maxSoFar := 0, 0
    for _, num := range arr {
        maxEndingHere = max(num, maxEndingHere + num)
        maxSoFar = max(maxSoFar, maxEndingHere)
    }
    return maxSoFar
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}