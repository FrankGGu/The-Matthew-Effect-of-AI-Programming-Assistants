package main

func countMaxOrSubsets(nums []int) int {
    maxOr := 0
    for _, num := range nums {
        maxOr |= num
    }

    count := 0
    var backtrack func(int, int)
    backtrack = func(start int, currentOr int) {
        if currentOr == maxOr {
            count++
            return
        }
        for i := start; i < len(nums); i++ {
            backtrack(i+1, currentOr|nums[i])
        }
    }

    backtrack(0, 0)
    return count
}