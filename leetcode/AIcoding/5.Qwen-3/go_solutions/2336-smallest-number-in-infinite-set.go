package main

type SmallestInfiniteSet struct {
    current int
    used    map[int]bool
}

func Constructor() SmallestInfiniteSet {
    return SmallestInfiniteSet{
        current: 1,
        used:    make(map[int]bool),
    }
}

func (this *SmallestInfiniteSet) PopSmallest() int {
    for this.used[this.current] {
        this.current++
    }
    this.used[this.current] = true
    return this.current
}

func (this *SmallestInfiniteSet) AddBack(num int) {
    if num < this.current {
        this.used[num] = false
    }
}