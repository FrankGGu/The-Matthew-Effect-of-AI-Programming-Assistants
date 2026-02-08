package main

func smallestEqual(nums []int) int {
    minIndex := -1
    for i, num := range nums {
        if i%10 == num%10 {
            if minIndex == -1 || i < minIndex {
                minIndex = i
            }
        }
    }
    return minIndex
}