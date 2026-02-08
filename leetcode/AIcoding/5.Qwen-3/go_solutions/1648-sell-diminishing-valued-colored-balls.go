package main

func sumPrice(baskets [][]int) int {
    const mod = 1000000007
    max := 0
    for _, basket := range baskets {
        if len(basket) > 0 {
            if basket[0] > max {
                max = basket[0]
            }
        }
    }
    res := 0
    for i := 1; i <= max; i++ {
        count := 0
        for _, basket := range baskets {
            for j := 0; j < len(basket); j++ {
                if basket[j] >= i {
                    count++
                }
            }
        }
        res = (res + count * i) % mod
    }
    return res
}