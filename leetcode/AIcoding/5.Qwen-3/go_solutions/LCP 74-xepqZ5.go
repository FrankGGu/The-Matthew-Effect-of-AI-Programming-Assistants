package main

func maxTotalFavor(favorites []int, power []int) int {
    n := len(favorites)
    m := len(power)
    res := 0
    for i := 0; i < n; i++ {
        cnt := 0
        for j := 0; j < m; j++ {
            if favorites[i] == power[j] {
                cnt++
            }
        }
        res += cnt * power[i]
    }
    return res
}