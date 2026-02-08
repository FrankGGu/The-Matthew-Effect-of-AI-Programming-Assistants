package main

import "math"

const mod = 1000000007

func numOfWays(nums []int) int {
    return (countWays(nums) - 1 + mod) % mod
}

func countWays(nums []int) int {
    if len(nums) <= 2 {
        return 1
    }
    left, right := []int{}, []int{}
    for _, num := range nums[1:] {
        if num < nums[0] {
            left = append(left, num)
        } else {
            right = append(right, num)
        }
    }
    return (countWays(left) * countWays(right) % mod * comb(len(left)+len(right), len(left))) % mod
}

func comb(n, k int) int {
    if k > n {
        return 0
    }
    if k == 0 || k == n {
        return 1
    }
    numerator, denominator := 1, 1
    for i := 0; i < k; i++ {
        numerator = (numerator * (n - i)) % mod
        denominator = (denominator * (i + 1)) % mod
    }
    return (numerator * modInverse(denominator)) % mod
}

func modInverse(x int) int {
    return pow(x, mod-2)
}

func pow(x, y int) int {
    res := 1
    x = x % mod
    for y > 0 {
        if y&1 == 1 {
            res = (res * x) % mod
        }
        y >>= 1
        x = (x * x) % mod
    }
    return res
}