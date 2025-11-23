package main

func subarrayBOs(nums []int) int {
    result := make(map[int]bool)
    prev := make(map[int]bool)
    for _, num := range nums {
        newPrev := make(map[int]bool)
        newPrev[num] = true
        for p := range prev {
            newPrev[p|num] = true
        }
        for p := range newPrev {
            result[p] = true
        }
        prev = newPrev
    }
    return len(result)
}