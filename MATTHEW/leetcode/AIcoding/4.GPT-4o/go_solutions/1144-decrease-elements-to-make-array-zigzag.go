func movesToMakeZigzag(nums []int) int {
    return min(calculateMoves(nums, true), calculateMoves(nums, false))
}

func calculateMoves(nums []int, isEven bool) int {
    moves := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        if isEven && i%2 == 0 {
            if i > 0 && nums[i] >= nums[i-1] {
                moves += nums[i] - nums[i-1] + 1
                nums[i] = nums[i-1] - 1
            }
            if i < n-1 && nums[i] >= nums[i+1] {
                moves += nums[i] - nums[i+1] + 1
                nums[i] = nums[i+1] - 1
            }
        } else if !isEven && i%2 == 1 {
            if i > 0 && nums[i] >= nums[i-1] {
                moves += nums[i] - nums[i-1] + 1
                nums[i] = nums[i-1] - 1
            }
            if i < n-1 && nums[i] >= nums[i+1] {
                moves += nums[i] - nums[i+1] + 1
                nums[i] = nums[i+1] - 1
            }
        }
    }
    return moves
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}