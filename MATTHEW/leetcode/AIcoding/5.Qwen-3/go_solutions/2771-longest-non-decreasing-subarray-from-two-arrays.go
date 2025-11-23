package main

func maxNonDecreasingSubseq(arr1, arr2 []int) int {
    n := len(arr1)
    m := len(arr2)

    dp1 := 1
    dp2 := 1

    for i := 1; i < n; i++ {
        newDp1 := 1
        newDp2 := 1

        if arr1[i] >= arr1[i-1] {
            newDp1 = max(newDp1, dp1 + 1)
        }
        if arr1[i] >= arr2[i-1] {
            newDp1 = max(newDp1, dp2 + 1)
        }

        if arr2[i] >= arr1[i-1] {
            newDp2 = max(newDp2, dp1 + 1)
        }
        if arr2[i] >= arr2[i-1] {
            newDp2 = max(newDp2, dp2 + 1)
        }

        dp1, dp2 = newDp1, newDp2
    }

    return max(dp1, dp2)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}