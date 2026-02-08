package main

func sumOfFlooredPairs(nums []int) int {
    const MOD = 1000000007
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    freq := make([]int, maxNum+1)
    for _, num := range nums {
        freq[num]++
    }

    res := 0
    for i := 1; i <= maxNum; i++ {
        if freq[i] == 0 {
            continue
        }
        for j := i; j <= maxNum; j += i {
            res = (res + freq[i]*freq[j]) % MOD
        }
    }

    return res
}