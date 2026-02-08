package main

func winningPlayers(score []int, k int) int {
    if k == 0 {
        return len(score)
    }
    maxScore := 0
    count := 0
    for _, s := range score {
        if s > maxScore {
            maxScore = s
            count = 1
        } else if s == maxScore {
            count++
        }
    }
    return count
}