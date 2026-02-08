package main

func PredictTheWinner(nums []int) bool {
    return dfs(nums, 0, len(nums)-1, 0, 0)
}

func dfs(nums []int, left, right, score1, score2 int) bool {
    if left > right {
        return score1 >= score2
    }
    if nums[left] > nums[right] {
        return dfs(nums, left+1, right, score1+nums[left], score2)
    } else {
        return dfs(nums, left, right-1, score1+nums[right], score2)
    }
}