package main

func longestCommonPrefix(arr []int) int {
    if len(arr) == 0 {
        return 0
    }
    minNum := arr[0]
    for _, num := range arr {
        if num < minNum {
            minNum = num
        }
    }
    prefix := 0
    for minNum > 0 {
        prefix++
        minNum /= 10
    }
    return prefix
}