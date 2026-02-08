package main

func dominantIndex(nums []int) int {
    max1 := -1
    max2 := -1
    index := -1
    for i, num := range nums {
        if num > max1 {
            max2 = max1
            max1 = num
            index = i
        } else if num > max2 {
            max2 = num
        }
    }
    if max1 >= 2*max2 {
        return index
    }
    return -1
}