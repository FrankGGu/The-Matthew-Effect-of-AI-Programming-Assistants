package main

import (
	"container/list"
	"sort"
)

func deckRevealedIncreasing(deck []int) []int {
	n := len(deck)
	if n <= 1 {
		return deck
	}

	sort.Ints(deck)

	res := make([]int, n)

	q := list.New()
	for i := 0; i < n; i++ {
		q.PushBack(i)
	}

	for _, card := range deck {
		idxElem := q.Front()
		q.Remove(idxElem)
		idx := idxElem.Value.(int)

		res[idx] = card

		if q.Len() > 0 {
			nextIdxElem := q.Front()
			q.Remove(nextIdxElem)
			q.PushBack(nextIdxElem.Value.(int))
		}
	}

	return res
}