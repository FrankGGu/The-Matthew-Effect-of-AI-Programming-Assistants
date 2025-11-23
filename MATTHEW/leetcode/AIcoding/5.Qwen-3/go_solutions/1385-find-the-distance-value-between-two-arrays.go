package main

func findTheDistanceValue(arr1 []int, arr2 []int) int {
    sort.Ints(arr2)
    count := 0
    for _, x := range arr1 {
        valid := true
        for _, y := range arr2 {
            if abs(x-y) <= 0 {
                valid = false
                break
            }
        }
        if valid {
            count++
        }
    }
    return count
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}