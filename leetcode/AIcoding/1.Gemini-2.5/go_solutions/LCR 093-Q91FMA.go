package main

func lenLongestFibSubseq(arr []int) int {
    n := len(arr)
    valToIndex := make(map[int]int, n)
    for i, val := range arr {
        valToIndex[val] = i
    }

    // dp[j][k] stores the length of the longest Fibonacci-like subsequence ending with arr[j] and arr[k].
    // Note that j < k.
    // dp table is initialized with 0s. A value of 0 means that arr[j], arr[k] has not yet been
    // identified as part of a longer Fibonacci subsequence.
    // If dp[i][j] is 0, it implies the length of the subsequence ending with arr[i], arr[j] is 2 (base pair).
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    maxLen := 0 // Will store the maximum length found. A length of 0 means no Fibonacci subsequence of length >= 3.

    // Iterate through all possible pairs (arr[j], arr[k]) where j < k to be the last two elements.
    for k := 0; k < n; k++ {
        for j := 0; j < k; j++ {
            // We are looking for arr[i] such that arr[i] + arr[j] = arr[k].
            // This means arr[i] = arr[k] - arr[j].
            prev := arr[k] - arr[j]

            // For a valid Fibonacci subsequence, arr[i] must be strictly less than arr[j].
            // Also, arr[i] must exist in the original array.
            if prev < arr[j] {
                if i, found := valToIndex[prev]; found {
                    // If arr[i] exists and i < j, we can extend the subsequence ending with arr[i], arr[j].
                    // The length of the subsequence ending with arr[i], arr[j] is dp[i][j].
                    // If dp[i][j] is 0, it means arr[i], arr[j] is a base pair, so its length is effectively 2.
                    // So, the current subsequence arr[i], arr[j], arr[k] has length (2 or dp[i][j]) + 1.

                    currentLen := 3 // Base length for arr[i], arr[j], arr[k]
                    if dp[i][j] > 0 { // If arr[i], arr[j] was already part of a longer sequence
                        currentLen = dp[i][j] + 1
                    }
                    dp[j][k] = currentLen
                    if currentLen > maxLen {
                        maxLen = currentLen
                    }
                }
            }
        }
    }

    return maxLen
}