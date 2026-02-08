package main

func maxChunksToMakeSorted(arr []int) int {
    chunks := 0
    maxSoFar := 0
    for i := 0; i < len(arr); i++ {
        if arr[i] > maxSoFar {
            maxSoFar = arr[i]
        }
        if maxSoFar == i {
            chunks++
        }
    }
    return chunks
}