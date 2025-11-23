package main

func maxTotalFruits(house []int, positions []int, fruits []int, k int) int {
    n := len(positions)
    pos := make([]int, n)
    for i := 0; i < n; i++ {
        pos[i] = positions[i]
    }
    sort.Ints(pos)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + fruits[i]
    }
    res := 0
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            if pos[j]-pos[i] > k {
                break
            }
            left := pos[i]
            right := pos[j]
            dist := right - left
            if dist <= k {
                res = max(res, prefix[j+1]-prefix[i])
            }
            if left-0 <= k {
                res = max(res, prefix[j+1]-prefix[i]+max(0, (k-(left-0))- (right-left)))
            }
            if right-0 <= k {
                res = max(res, prefix[j+1]-prefix[i]+max(0, (k-(right-0))- (right-left)))
            }
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}