package main

func earliestAndLatest(n int, a int, b int) []int {
    var dfs func(int, int) (int, int)
    dfs = func(l, r int) (int, int) {
        if l == r {
            return 0, 0
        }
        mid := (l + r) / 2
        leftMin, leftMax := dfs(l, mid)
        rightMin, rightMax := dfs(mid+1, r)
        if a <= mid && b <= mid {
            return leftMin + 1, leftMax + 1
        }
        if a > mid && b > mid {
            return rightMin + 1, rightMax + 1
        }
        return leftMin + 1, rightMax + 1
    }
    minRound, maxRound := dfs(1, n)
    return []int{minRound, maxRound}
}