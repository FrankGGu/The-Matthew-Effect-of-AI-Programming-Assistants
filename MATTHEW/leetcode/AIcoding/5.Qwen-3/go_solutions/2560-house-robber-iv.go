package main

func deleteAndEarn(n int, nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    count := make([]int, maxNum+1)
    for _, num := range nums {
        count[num]++
    }

    prev := 0
    curr := 0
    for i := 1; i <= maxNum; i++ {
        temp := curr
        curr = max(curr, prev+count[i]*i)
        prev = temp
    }

    return curr
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}