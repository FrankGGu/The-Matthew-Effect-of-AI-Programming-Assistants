package main

func getWinner(arr []int, k int) int {
    maxNum := arr[0]
    for _, num := range arr[1:] {
        if num > maxNum {
            maxNum = num
        }
    }
    count := 0
    for i := 1; i < len(arr); i++ {
        if arr[i] > arr[i-1] {
            count = 1
        } else {
            count++
        }
        if count == k || arr[i] == maxNum {
            return arr[i]
        }
    }
    return arr[0]
}