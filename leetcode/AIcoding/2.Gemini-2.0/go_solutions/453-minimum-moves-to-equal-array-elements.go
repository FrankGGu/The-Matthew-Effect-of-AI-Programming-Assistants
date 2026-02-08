func minMoves(nums []int) int {
    min := nums[0]
    for _, num := range nums {
        if num < min {
            min = num
        }
    }
    moves := 0
    for _, num := range nums {
        moves += num - min
    }
    return moves
}