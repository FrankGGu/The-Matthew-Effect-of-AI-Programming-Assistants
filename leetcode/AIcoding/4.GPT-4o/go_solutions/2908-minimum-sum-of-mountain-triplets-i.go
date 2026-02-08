func minimumSumOfMountainTriplets(arr []int) int {
    n := len(arr)
    if n < 3 {
        return 0
    }

    minSum := int(^uint(0) >> 1)

    for i := 1; i < n-1; i++ {
        leftMin := int(^uint(0) >> 1)
        for j := 0; j < i; j++ {
            if arr[j] < arr[i] {
                leftMin = min(leftMin, arr[j])
            }
        }

        rightMin := int(^uint(0) >> 1)
        for k := i + 1; k < n; k++ {
            if arr[k] < arr[i] {
                rightMin = min(rightMin, arr[k])
            }
        }

        if leftMin != int(^uint(0) >> 1) && rightMin != int(^uint(0) >> 1) {
            minSum = min(minSum, leftMin + arr[i] + rightMin)
        }
    }

    if minSum == int(^uint(0) >> 1) {
        return 0
    }
    return minSum
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}