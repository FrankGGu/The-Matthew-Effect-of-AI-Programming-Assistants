package main

func numFriendRequests(ageScores []int) int {
    count := make([]int, 121)
    for _, age := range ageScores {
        count[age]++
    }
    res := 0
    for i := 1; i <= 120; i++ {
        if count[i] == 0 {
            continue
        }
        for j := 1; j <= 120; j++ {
            if count[j] == 0 {
                continue
            }
            if j > i {
                continue
            }
            if j > 100 && i < 100 {
                continue
            }
            if j <= i/2 + 10 {
                continue
            }
            if i == j {
                res += count[i] * (count[i] - 1)
            } else {
                res += count[i] * count[j]
            }
        }
    }
    return res
}