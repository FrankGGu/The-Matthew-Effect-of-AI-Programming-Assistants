func permute(nums []int) [][]int {
    var res [][]int
    backtrack(nums, 0, &res)
    return res
}

func backtrack(nums []int, start int, res *[][]int) {
    if start == len(nums) {
        tmp := make([]int, len(nums))
        copy(tmp, nums)
        *res = append(*res, tmp)
        return
    }
    for i := start; i < len(nums); i++ {
        nums[start], nums[i] = nums[i], nums[start]
        backtrack(nums, start+1, res)
        nums[start], nums[i] = nums[i], nums[start]
    }
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func calculateManhattan(p1, p2 []int) int {
    return abs(p1[0]-p2[0]) + abs(p1[1]-p2[1])
}

func totalManhattanDistances(pieces [][]int) int {
    n := len(pieces)
    if n == 0 {
        return 0
    }
    indices := make([]int, n)
    for i := 0; i < n; i++ {
        indices[i] = i
    }
    perms := permute(indices)
    total := 0
    for _, perm := range perms {
        sum := 0
        for i := 0; i < n-1; i++ {
            sum += calculateManhattan(pieces[perm[i]], pieces[perm[i+1]])
        }
        total += sum
    }
    return total
}