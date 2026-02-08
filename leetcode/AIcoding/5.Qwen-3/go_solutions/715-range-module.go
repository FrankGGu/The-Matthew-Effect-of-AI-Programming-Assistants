package main

type RangeModule struct {
    ranges [][2]int
}

func Constructor() RangeModule {
    return RangeModule{}
}

func (this *RangeModule) AddRange(range_ [2]int) {
    newRanges := [][2]int{}
    i := 0
    n := len(this.ranges)
    for i < n && this.ranges[i][1] < range_[0] {
        newRanges = append(newRanges, this.ranges[i])
        i++
    }
    for i < n && this.ranges[i][0] <= range_[1] {
        range_[0] = min(range_[0], this.ranges[i][0])
        range_[1] = max(range_[1], this.ranges[i][1])
        i++
    }
    newRanges = append(newRanges, range_)
    for i < n {
        newRanges = append(newRanges, this.ranges[i])
        i++
    }
    this.ranges = newRanges
}

func (this *RangeModule) QueryRange(range_ [2]int) bool {
    left, right := 0, len(this.ranges)-1
    for left <= right {
        mid := (left + right) / 2
        if this.ranges[mid][0] > range_[1] {
            right = mid - 1
        } else if this.ranges[mid][1] < range_[0] {
            left = mid + 1
        } else {
            return true
        }
    }
    return false
}

func (this *RangeModule) RemoveRange(range_ [2]int) {
    newRanges := [][2]int{}
    i := 0
    n := len(this.ranges)
    for i < n {
        if this.ranges[i][1] < range_[0] || this.ranges[i][0] > range_[1] {
            newRanges = append(newRanges, this.ranges[i])
            i++
        } else {
            if this.ranges[i][0] < range_[0] {
                newRanges = append(newRanges, [2]int{this.ranges[i][0], range_[0]})
            }
            if this.ranges[i][1] > range_[1] {
                newRanges = append(newRanges, [2]int{range_[1], this.ranges[i][1]})
            }
            i++
        }
    }
    this.ranges = newRanges
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}