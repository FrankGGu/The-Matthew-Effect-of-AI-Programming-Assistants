func sumOddLengthSubarrays(arr []int) int {
    n := len(arr)
    totalSum := 0

    for i := 0; i < n; i++ {
        for length := 1; length <= n-i; length += 2 {
            totalSum += sum(arr[i : i+length])
        }
    }

    return totalSum
}

func sum(subarr []int) int {
    total := 0
    for _, v := range subarr {
        total += v
    }
    return total
}