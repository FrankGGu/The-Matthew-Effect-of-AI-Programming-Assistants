package main

func countTestedDevices(arr []int) int {
    count := 0
    for _, v := range arr {
        if v > 0 {
            count++
            for i := range arr {
                if arr[i] > 0 {
                    arr[i]--
                }
            }
        }
    }
    return count
}