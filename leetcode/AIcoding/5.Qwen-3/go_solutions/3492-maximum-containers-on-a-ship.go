package main

func maxBoxesInContainer(containerSize int, boxSizes []int) int {
    sort.Ints(boxSizes)
    count := 0
    for i := len(boxSizes) - 1; i >= 0; i-- {
        if containerSize >= boxSizes[i] {
            count++
            containerSize -= boxSizes[i]
        }
    }
    return count
}