const MOD = 1e9 + 7

func numOfWays(nums []int) int {
    n := len(nums)
    comb := make([][]int, n+1)
    for i := 0; i <= n; i++ {
        comb[i] = make([]int, i+1)
        comb[i][0], comb[i][i] = 1, 1
        for j := 1; j < i; j++ {
            comb[i][j] = (comb[i-1][j-1] + comb[i-1][j]) % MOD
        }
    }
    return (helper(nums, comb) - 1 + MOD) % MOD
}

func helper(nums []int, comb [][]int) int {
    if len(nums) <= 2 {
        return 1
    }
    left, right := []int{}, []int{}
    for _, num := range nums[1:] {
        if num < nums[0] {
            left = append(left, num)
        } else {
            right = append(right, num)
        }
    }
    l := helper(left, comb)
    r := helper(right, comb)
    res := comb[len(left)+len(right)][len(left)]
    res = res * l % MOD
    res = res * r % MOD
    return res
}