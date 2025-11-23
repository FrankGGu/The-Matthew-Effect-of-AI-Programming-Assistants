func prevPermutation(arr []int) []int {
    n := len(arr)
    if n <= 1 {
        return arr
    }

    // Step 1: Find the largest index i such that arr[i] > arr[i+1].
    // If no such index exists, the array is