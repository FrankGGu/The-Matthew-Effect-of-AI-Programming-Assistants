package main

func tallestBillboard(s []int) int {
    dp := map[int]int{0: 0}
    for _, c := range s {
        newDp := make(map[int]int)
        for k, v := range dp {
            newDp[k] = v
        }
        for k, v := range dp {
            newK := k + c
            newV := v + c
            if val, ok := newDp[newK]; !ok || newV > val {
                newDp[newK] = newV
            }
            newK = k - c
            newV = v
            if val, ok := newDp[newK]; !ok || newV > val {
                newDp[newK] = newV
            }
        }
        dp = newDp
    }
    return dp[0]
}