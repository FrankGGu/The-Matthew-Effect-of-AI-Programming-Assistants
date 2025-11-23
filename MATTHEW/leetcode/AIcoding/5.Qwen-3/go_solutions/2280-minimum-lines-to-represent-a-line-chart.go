package main

func minLines(n int, xCoordinates []int, yCoordinates []int) int {
    if n <= 1 {
        return 0
    }
    sort.Ints(xCoordinates)
    sort.Ints(yCoordinates)
    count := 1
    for i := 1; i < n-1; i++ {
        if (yCoordinates[i] - yCoordinates[i-1])*(xCoordinates[i+1] - xCoordinates[i]) != (yCoordinates[i+1] - yCoordinates[i])*(xCoordinates[i] - xCoordinates[i-1]) {
            count++
        }
    }
    return count
}