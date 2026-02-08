package main

func maxCoins(piles []int) int {
    sort.Ints(piles)
    n := len(piles)
    res := 0
    for i := n - 2; i >= n/3; i -= 2 {
        res += piles[i]
    }
    return res
}