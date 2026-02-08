func missingObservations(observed []int, n int) []int {
    sumObserved := 0
    for _, num := range observed {
        sumObserved += num
    }
    expectedSum := n * (n + 1) / 2
    missingSum := expectedSum - sumObserved

    count := len(observed)
    missingCount := n - count
    missing := make([]int, missingCount)

    for i := 0; i < missingCount; i++ {
        missing[i] = (missingSum + i + 1) / (missingCount - i)
        missingSum -= missing[i]
    }

    return missing
}