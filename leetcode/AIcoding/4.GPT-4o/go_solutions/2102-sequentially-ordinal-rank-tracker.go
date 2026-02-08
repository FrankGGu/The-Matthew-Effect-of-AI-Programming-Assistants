type OrdinalRankTracker struct {
    nums []int
    count map[int]int
}

func Constructor() OrdinalRankTracker {
    return OrdinalRankTracker{
        nums:  []int{},
        count: make(map[int]int),
    }
}

func (this *OrdinalRankTracker) Track(num int) {
    this.nums = append(this.nums, num)
    this.count[num]++
}

func (this *OrdinalRankTracker) GetOrdinalRank(num int) int {
    rank := 1
    for _, n := range this.nums {
        if n < num {
            rank++
        }
    }
    return rank
}