func minMoves(nums []int) int {
    minNum := nums[0]
    for _, num := range nums {
        if num < minNum {
            minNum = num
        }
    }

    moves := 0
    for _, num := range nums {
        moves += num - minNum
    }

    return moves
}