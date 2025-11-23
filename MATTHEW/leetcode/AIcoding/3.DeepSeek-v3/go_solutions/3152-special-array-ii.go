func isArraySpecial(nums []int, queries [][]int) []bool {
    n := len(nums)
    prefix := make([]int, n)
    for i := 1; i < n; i++ {
        if nums[i]%2 == nums[i-1]%2 {
            prefix[i] = prefix[i-1] + 1
        } else {
            prefix[i] = prefix[i-1]
        }
    }

    res := make([]bool, len(queries))
    for i, q := range queries {
        x, y := q[0], q[1]
        if x == y {
            res[i] = true
        } else {
            res[i] = prefix[y] == prefix[x]
        }
    }
    return res
}