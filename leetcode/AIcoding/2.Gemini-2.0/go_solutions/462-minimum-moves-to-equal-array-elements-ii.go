import "sort"

func minMoves2(nums []int) int {
    sort.Ints(nums)
    median := nums[len(nums)/2]
    moves := 0
    for _, num := range nums {
        moves += abs(num - median)
    }
    return moves
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}