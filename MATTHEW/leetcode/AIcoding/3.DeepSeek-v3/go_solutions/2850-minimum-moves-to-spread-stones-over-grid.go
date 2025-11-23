func minimumMoves(grid [][]int) int {
    var stones, holes [][2]int
    for i := 0; i < 3; i++ {
        for j := 0; j < 3; j++ {
            if grid[i][j] > 1 {
                for k := 0; k < grid[i][j]-1; k++ {
                    stones = append(stones, [2]int{i, j})
                }
            } else if grid[i][j] == 0 {
                holes = append(holes, [2]int{i, j})
            }
        }
    }
    if len(stones) == 0 {
        return 0
    }

    n := len(stones)
    perm := make([]int, n)
    for i := 0; i < n; i++ {
        perm[i] = i
    }

    minMoves := 1 << 31 - 1
    for {
        total := 0
        for i := 0; i < n; i++ {
            stone := stones[i]
            hole := holes[perm[i]]
            total += abs(stone[0]-hole[0]) + abs(stone[1]-hole[1])
        }
        if total < minMoves {
            minMoves = total
        }
        if !nextPermutation(perm) {
            break
        }
    }
    return minMoves
}

func nextPermutation(nums []int) bool {
    n := len(nums)
    i := n - 2
    for i >= 0 && nums[i] >= nums[i+1] {
        i--
    }
    if i < 0 {
        return false
    }
    j := n - 1
    for j >= 0 && nums[j] <= nums[i] {
        j--
    }
    nums[i], nums[j] = nums[j], nums[i]
    reverse(nums[i+1:])
    return true
}

func reverse(nums []int) {
    for i, j := 0, len(nums)-1; i < j; i, j = i+1, j-1 {
        nums[i], nums[j] = nums[j], nums[i]
    }
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}