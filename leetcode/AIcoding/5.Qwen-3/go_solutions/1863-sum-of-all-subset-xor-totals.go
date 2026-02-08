package main

func subsetXORs(nums []int) int {
    var result int
    var backtrack func(int, int)
    backtrack = func(start int, current int) {
        if start == len(nums) {
            result += current
            return
        }
        backtrack(start+1, current^nums[start])
        backtrack(start+1, current)
    }
    backtrack(0, 0)
    return result
}