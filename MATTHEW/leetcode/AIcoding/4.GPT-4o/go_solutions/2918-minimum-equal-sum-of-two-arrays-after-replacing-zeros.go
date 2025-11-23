func minEqualSum(arr1 []int, arr2 []int) int {
    sum1, sum2 := 0, 0
    for _, num := range arr1 {
        sum1 += num
    }
    for _, num := range arr2 {
        sum2 += num
    }

    if sum1 == sum2 {
        return sum1
    }

    diff := abs(sum1 - sum2)
    return min(sum1, sum2) - diff/2
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