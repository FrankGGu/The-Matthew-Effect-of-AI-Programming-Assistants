package main

import (
	"math/rand"
)

type Solution struct {
	m, n   int
	count  int
	index  map[int]int
}

func Constructor(m int, n int) Solution {
	return Solution{
		m:     m,
		n:     n,
		count: 0,
		index: make(map[int]int),
	}
}

func (this *Solution) Flip() []int {
	total := this.m * this.n
	if this.count >= total {
		return nil
	}

	randIndex := rand.Intn(total - this.count)
	actualIndex := this.index[randIndex]
	if actualIndex == 0 {
		actualIndex = randIndex
	}
	if val, ok := this.index[total-1-this.count]; ok {
		this.index[randIndex] = val
	} else {
		this.index[randIndex] = total - 1 - this.count
	}
	this.index[total-1-this.count] = actualIndex
	this.count++

	return []int{actualIndex / this.n, actualIndex % this.n}
}

func (this *Solution) Reset() {
	this.count = 0
	this.index = make(map[int]int)
}