package main

func topVotedCandidate(q []int) []int {
    n := len(q)
    res := make([]int, n)
    votes := make(map[int]int)
    maxVote := 0
    currentLeader := -1
    timeToLeader := make(map[int]int)

    for i := 0; i < n; i++ {
        time := q[i]
        votes[time]++
        if votes[time] > maxVote {
            maxVote = votes[time]
            currentLeader = time
        } else if votes[time] == maxVote {
            currentLeader = time
        }
        timeToLeader[time] = currentLeader
    }

    for i := 0; i < n; i++ {
        res[i] = timeToLeader[q[i]]
    }

    return res
}