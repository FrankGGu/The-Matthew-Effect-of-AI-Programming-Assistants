package main

type RLEIterator struct {
    nums []int
    index int
}

func Constructor(n []int) RLEIterator {
    return RLEIterator{
        nums: n,
        index: 0,
    }
}

func (this *RLEIterator) Next(n int) int {
    for this.index < len(this.nums) {
        if this.nums[this.index] >= n {
            this.nums[this.index] -= n
            return this.nums[this.index+1]
        }
        n -= this.nums[this.index]
        this.index += 2
    }
    return -1
}