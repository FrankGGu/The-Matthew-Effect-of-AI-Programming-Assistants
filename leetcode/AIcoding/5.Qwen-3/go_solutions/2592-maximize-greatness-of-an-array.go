package main

func maximizeGreatness(nums []int) int {
    sort.Ints(nums)
    i := 0
    for j := 0; j < len(nums); j++ {
        if nums[i] < nums[j] {
            i++
        }
    }
    return i
}