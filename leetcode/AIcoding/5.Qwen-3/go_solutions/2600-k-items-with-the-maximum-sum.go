package main

func kItemsWithMaximumSum(k int, nCoins int, coins []int, k1 int) int {
    sum := 0
    for i := 0; i < k1; i++ {
        sum += coins[i]
    }
    return sum
}