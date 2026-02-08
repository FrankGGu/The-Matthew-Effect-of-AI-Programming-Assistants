func countMaxOrSubsets(nums []int) int {
    maxOr := 0
    for _, num := range nums {
        maxOr |= num
    }

    var count int
    var backtrack func(index, currentOr int)
    backtrack = func(index, currentOr int) {
        if currentOr == maxOr {
            count += 1 << (len(nums) - index)
            return
        }
        if index == len(nums) {
            return
        }
        backtrack(index+1, currentOr | nums[index])
        backtrack(index+1, currentOr)
    }
    backtrack(0, 0)
    return count
}