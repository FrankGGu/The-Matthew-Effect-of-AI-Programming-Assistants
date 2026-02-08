type TopVotedCandidate struct {
    times []int
    leaders []int
}

func Constructor(persons []int, times []int) TopVotedCandidate {
    count := make(map[int]int)
    leader := -1
    maxVotes := 0
    leaders := make([]int, len(times))

    for i, p := range persons {
        count[p]++
        if count[p] >= maxVotes {
            maxVotes = count[p]
            leader = p
        }
        leaders[i] = leader
    }

    return TopVotedCandidate{times: times, leaders: leaders}
}

func (this *TopVotedCandidate) Q(t int) int {
    left, right := 0, len(this.times)-1
    for left < right {
        mid := left + (right-left)/2
        if this.times[mid] <= t {
            left = mid + 1
        } else {
            right = mid
        }
    }
    if this.times[left] > t {
        left--
    }
    return this.leaders[left]
}