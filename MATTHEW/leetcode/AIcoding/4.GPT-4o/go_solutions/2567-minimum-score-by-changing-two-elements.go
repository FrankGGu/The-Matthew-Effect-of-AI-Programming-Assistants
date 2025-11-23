func minimizeScore(nums []int, edges [][]int) int {
    n := len(nums)
    minNum := nums[0]
    maxNum := nums[0]

    for _, num := range nums {
        if num < minNum {
            minNum = num
        }
        if num > maxNum {
            maxNum = num
        }
    }

    return maxNum - minNum
}