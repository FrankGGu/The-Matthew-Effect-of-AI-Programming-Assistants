package main

func minAbsoluteSumDifference(arr1 []int, arr2 []int) int {
    n := len(arr1)
    sortedArr1 := make([]int, n)
    copy(sortedArr1, arr1)
    sort.Ints(sortedArr1)

    minDiff := 0
    for i := 0; i < n; i++ {
        minDiff += abs(arr1[i] - arr2[i])
    }

    for i := 0; i < n; i++ {
        target := arr2[i]
        left, right := 0, n-1
        best := arr1[0]
        for left <= right {
            mid := left + (right-left)/2
            if sortedArr1[mid] == target {
                best = target
                break
            } else if sortedArr1[mid] < target {
                left = mid + 1
                best = sortedArr1[mid]
            } else {
                right = mid - 1
                best = sortedArr1[mid]
            }
        }
        currentDiff := abs(arr1[i] - arr2[i])
        newDiff := abs(best - arr2[i])
        if newDiff < currentDiff {
            minDiff = minDiff - currentDiff + newDiff
        }
    }

    return minDiff
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}