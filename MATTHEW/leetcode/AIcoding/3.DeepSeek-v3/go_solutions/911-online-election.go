type TopVotedCandidate struct {
    times []int
    leaders []int
}

func Constructor(persons []int, times []int) TopVotedCandidate {
    leader := -1
    voteCount := make(map[int]int)
    leaders := make([]int, len(persons))

    for i := 0; i < len(persons); i++ {
        p := persons[i]
        voteCount[p]++
        if i == 0 || voteCount[p] >= voteCount[leader] {
            leader = p
        }
        leaders[i] = leader
    }

    return TopVotedCandidate{times: times, leaders: leaders}
}

func (this *TopVotedCandidate) Q(t int) int {
    left, right := 0, len(this.times)-1
    for left <= right {
        mid := left + (right-left)/2
        if this.times[mid] == t {
            return this.leaders[mid]
        } else if this.times[mid] < t {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return this.leaders[right]
}