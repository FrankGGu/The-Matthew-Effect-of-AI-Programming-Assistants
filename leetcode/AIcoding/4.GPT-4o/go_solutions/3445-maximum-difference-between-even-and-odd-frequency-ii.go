func maximumDifference(nums []int) int {
    evenCount := make([]int, 101)
    oddCount := make([]int, 101)

    for _, num := range nums {
        if num%2 == 0 {
            evenCount[num]++
        } else {
            oddCount[num]++
        }
    }

    maxEven := -1
    minOdd := 101

    for i := 0; i <= 100; i++ {
        if evenCount[i] > 0 {
            maxEven = max(maxEven, i)
        }
        if oddCount[i] > 0 {
            minOdd = min(minOdd, i)
        }
    }

    if maxEven == -1 || minOdd == 101 {
        return -1
    }

    return maxEven - minOdd
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}