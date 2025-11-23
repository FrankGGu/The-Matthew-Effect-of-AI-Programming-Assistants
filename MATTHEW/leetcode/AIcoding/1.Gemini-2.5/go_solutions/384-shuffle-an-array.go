package main

import (
	"math/rand"
	"time"
)

type Solution struct {
	original []int
	current  []int
}

func Constructor(nums []int) Solution {
	rand.Seed(time.Now().UnixNano())
	originalCopy := make([]int, len(nums))
	copy(originalCopy, nums)
	currentCopy := make([]int, len(nums))
	copy(currentCopy, nums)
	return Solution{
		original: originalCopy,
		current:  currentCopy,
	}
}

func (this *Solution) Reset() []int {
	copy(this.current, this.original)
	return this.current
}

func (this *Solution) Shuffle() []int {
	n := len(this.current)
	for i := n - 1; i > 0; i-- {
		j := rand.Intn(i + 1)
		this.current[i], this.current[j] = this.current[j], this.current[i]
	}
	return this.current
}