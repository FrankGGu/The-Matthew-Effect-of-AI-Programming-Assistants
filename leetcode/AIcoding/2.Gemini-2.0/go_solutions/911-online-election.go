type TopVotedCandidate struct {
    votes []int
    times []int
    leaders []int
}

func Constructor(persons []int, times []int) TopVotedCandidate {
    votes := make([]int, len(persons))
    leaders := make([]int, len(persons))
    maxVote := 0
    leader := -1
    for i, p := range persons {
        votes[p]++
        if votes[p] >= maxVote {
            maxVote = votes[p]
            leader = p
        }
        leaders[i] = leader
    }
    return TopVotedCandidate{
        votes: votes,
        times: times,
        leaders: leaders,
    }
}

func (this *TopVotedCandidate) Q(t int) int {
    l, r := 0, len(this.times)-1
    for l <= r {
        mid := l + (r-l)/2
        if this.times[mid] <= t {
            l = mid + 1
        } else {
            r = mid - 1
        }
    }
    return this.leaders[r]
}