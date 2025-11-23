package main

func maxTotalFruits(position []int, amount []int, k int) int {
    n := len(position)
    type pair struct {
        pos int
        amt int
    }
    arr := make([]pair, n)
    for i := 0; i < n; i++ {
        arr[i] = pair{position[i], amount[i]}
    }
    sort.Slice(arr, func(i, j int) bool {
        return arr[i].pos < arr[j].pos
    })
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + arr[i].amt
    }
    res := 0
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            if arr[j].pos-arr[i].pos > k {
                break
            }
            left := arr[i].pos
            right := arr[j].pos
            cost := right - left
            if cost <= k {
                res = max(res, prefix[j+1]-prefix[i])
            } else {
                dist := k
                if right-left <= k {
                    res = max(res, prefix[j+1]-prefix[i])
                } else {
                    for l := i; l <= j; l++ {
                        if arr[l].pos-left <= k {
                            res = max(res, prefix[j+1]-prefix[l])
                        }
                        if right-arr[l].pos <= k {
                            res = max(res, prefix[j+1]-prefix[i])
                        }
                    }
                }
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