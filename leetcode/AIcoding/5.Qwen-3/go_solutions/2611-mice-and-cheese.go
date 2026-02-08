package main

func miceAndCheese(grains []int, reward1 int, reward2 int) int {
    n := len(grains)
    for i := 0; i < n; i++ {
        grains[i] = grains[i]*reward1 - grains[i]*reward2
    }
    for i := 0; i < n-1; i++ {
        for j := 0; j < n-i-1; j++ {
            if grains[j] < grains[j+1] {
                grains[j], grains[j+1] = grains[j+1], grains[j]
            }
        }
    }
    res := 0
    for i := 0; i < n; i++ {
        if i < n/2 {
            res += grains[i] + grains[i]*reward2
        } else {
            res += grains[i]*reward2
        }
    }
    return res
}