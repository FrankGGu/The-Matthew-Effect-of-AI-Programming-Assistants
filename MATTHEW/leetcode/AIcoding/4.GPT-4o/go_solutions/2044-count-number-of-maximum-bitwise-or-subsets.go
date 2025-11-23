func countMaxOrSubsets(nums []int) int {
    maxOr := 0
    count := 0

    var dfs func(int, int)
    dfs = func(index int, currentOr int) {
        if index == len(nums) {
            if currentOr > maxOr {
                maxOr = currentOr
                count = 1
            } else if currentOr == maxOr {
                count++
            }
            return
        }
        dfs(index+1, currentOr)
        dfs(index+1, currentOr|nums[index])
    }

    dfs(0, 0)
    return count
}