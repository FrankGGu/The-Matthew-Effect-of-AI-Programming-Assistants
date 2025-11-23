package main

func numGoodWays(s string) int {
    leftCount := make(map[byte]int)
    rightCount := make(map[byte]int)
    for i := 0; i < len(s); i++ {
        rightCount[s[i]]++
    }
    res := 0
    for i := 0; i < len(s); i++ {
        leftCount[s[i]]++
        rightCount[s[i]]--
        if rightCount[s[i]] == 0 {
            delete(rightCount, s[i])
        }
        if len(leftCount) == len(rightCount) {
            res++
        }
    }
    return res
}