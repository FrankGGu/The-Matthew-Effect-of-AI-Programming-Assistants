package main

func longestSquareStreak(nums []int) int {
    sort.Ints(nums)
    mp := make(map[int]int)
    maxLen := 0

    for _, num := range nums {
        if val, ok := mp[num]; ok {
            mp[num*num] = val + 1
            if mp[num*num] > maxLen {
                maxLen = mp[num*num]
            }
        } else {
            mp[num*num] = 1
        }
    }

    if maxLen < 2 {
        return -1
    }
    return maxLen
}