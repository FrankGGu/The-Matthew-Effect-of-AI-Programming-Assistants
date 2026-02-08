package main

func maxBuilding(n int, k [][]int) int {
    type pair struct {
        idx int
        h   int
    }
    var constraints []pair
    for _, v := range k {
        constraints = append(constraints, pair{v[0], v[1]})
    }
    constraints = append(constraints, pair{n - 1, 0})
    sort.Slice(constraints, func(i, j int) bool {
        return constraints[i].idx < constraints[j].idx
    })
    m := len(constraints)
    res := 0
    for i := 0; i < m; i++ {
        if i > 0 {
            prev := constraints[i-1]
            curr := constraints[i]
            diff := curr.idx - prev.idx
            maxH := (prev.h + curr.h + diff) / 2
            res = max(res, maxH)
            if prev.h < curr.h {
                res = max(res, curr.h)
            } else {
                res = max(res, prev.h)
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