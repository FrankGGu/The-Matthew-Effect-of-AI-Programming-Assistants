package main

func xorBeauty(arr []int) int {
    n := len(arr)
    res := 0
    for i := 0; i < 30; i++ {
        cnt := 0
        for j := 0; j < n; j++ {
            if (arr[j] >> i) & 1 == 1 {
                cnt++
            }
        }
        if cnt > 0 {
            res |= (1 << i) * (cnt % 2)
        }
    }
    return res
}