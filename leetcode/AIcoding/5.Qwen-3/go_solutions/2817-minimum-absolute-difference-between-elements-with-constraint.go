package main

func minimumAbsoluteDifference(arr []int) int {
    sort.Ints(arr)
    minDiff := math.MaxInt
    for i := 0; i < len(arr)-1; i++ {
        diff := arr[i+1] - arr[i]
        if diff < minDiff {
            minDiff = diff
        }
    }
    return minDiff
}