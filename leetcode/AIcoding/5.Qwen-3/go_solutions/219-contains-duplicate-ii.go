package main

func containsNearbyDuplicate(nums []int, k int) bool {
    numMap := make(map[int]int)
    for i, num := range nums {
        if prevIndex, found := numMap[num]; found && i-prevIndex <= k {
            return true
        }
        numMap[num] = i
    }
    return false
}