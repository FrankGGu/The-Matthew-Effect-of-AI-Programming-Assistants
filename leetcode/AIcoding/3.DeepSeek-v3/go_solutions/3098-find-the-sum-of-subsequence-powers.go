func sumOfPowers(nums []int, k int) int {
    n := len(nums)
    sort.Ints(nums)
    mod := int(1e9 + 7)

    memo := make([][][]int, n)
    for i := range memo {
        memo[i] = make([][]int, k+1)
        for j := range memo[i] {
            memo[i][j] = make([]int, n)
            for l := range memo[i][j] {
                memo[i][j][l] = -1
            }
        }
    }

    var dfs func(int, int, int) int
    dfs = func(i, left, lastDiffIndex int) int {
        if left == 0 {
            if lastDiffIndex != n {
                return 1
            }
            return 0
        }
        if i == n {
            return 0
        }
        if memo[i][left][lastDiffIndex] != -1 {
            return memo[i][left][lastDiffIndex]
        }

        res := dfs(i+1, left, lastDiffIndex)
        newDiffIndex := lastDiffIndex
        if lastDiffIndex == n {
            newDiffIndex = i
        } else {
            diff := nums[i] - nums[lastDiffIndex]
            if diff < nums[newDiffIndex] - nums[lastDiffIndex] {
                newDiffIndex = i
            }
        }
        res = (res + dfs(i+1, left-1, newDiffIndex)) % mod
        memo[i][left][lastDiffIndex] = res
        return res
    }

    return dfs(0, k, n)
}