package main

func maxOperations(nums []int, k int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    res := 0
    for num, freq := range count {
        if num < k-num {
            if cnt, ok := count[k-num]; ok {
                res += min(freq, cnt)
            }
        } else if num == k-num {
            res += freq / 2
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}