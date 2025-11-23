package main

type Election struct {
    time []int
    vote []int
}

func Constructor(winnerVotes []int, votes []int) Election {
    time := make([]int, len(votes))
    vote := make([]int, len(votes))
    for i := 0; i < len(votes); i++ {
        time[i] = i
        vote[i] = winnerVotes[votes[i]]
    }
    return Election{time, vote}
}

func (e *Election) Q(t int) int {
    left, right := 0, len(e.time)-1
    for left < right {
        mid := (left + right + 1) / 2
        if e.time[mid] <= t {
            left = mid
        } else {
            right = mid - 1
        }
    }
    return e.vote[left]
}