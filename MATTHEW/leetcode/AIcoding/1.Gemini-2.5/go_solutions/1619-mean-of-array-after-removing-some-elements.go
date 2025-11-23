func trimMean(arr []int) float64 {
    sort.Ints(arr)

    n := len(arr)
    elementsToRemove := n / 20 // 5% of n. Since n is a multiple of 20, this is an integer.

    sum := 0
    // Iterate from the (elementsToRemove)-th element to the (n - elementsToRemove - 1)-th element
    // This effectively skips the smallest elementsToRemove and largest elementsToRemove
    for i := elementsToRemove; i < n - elementsToRemove; i++ {
        sum += arr[i]
    }

    // The number of elements remaining after removal
    count := n - 2 * elementsToRemove

    return float64(sum) / float64(count)
}