package main

func numOfWays(nums []int) int {
    mod := int(1e9 + 7)
    var dfs func([]int) int
    dfs = func(nums []int) int {
        if len(nums) <= 1 {
            return 1
        }
        root := nums[0]
        left := []int{}
        right := []int{}
        for _, num := range nums[1:] {
            if num < root {
                left = append(left, num)
            } else {
                right = append(right, num)
            }
        }
        l := dfs(left)
        r := dfs(right)
        return (comb(len(nums)-1, len(left), mod) * l % mod) * r % mod
    }
    return (dfs(nums) - 1) % mod
}

func comb(n, k, mod int) int {
    if k > n-k {
        k = n - k
    }
    res := 1
    for i := 0; i < k; i++ {
        res = res * (n - i) % mod
        res = res * pow(i+1, mod-2, mod) % mod
    }
    return res
}

func pow(a, b, mod int) int {
    result := 1
    a = a % mod
    for b > 0 {
        if b%2 == 1 {
            result = result * a % mod
        }
        a = a * a % mod
        b /= 2
    }
    return result
}