package main

import (
	"sort"
)

type car struct {
	position int
	speed    int
}

func carFleet(target int, position []int, speed []int) int {
	n := len(position)
	if n == 0 {
		return 0
	}

	cars := make([]car, n)
	for i := 0; i < n; i++ {
		cars[i] = car{position: position[i], speed: speed[i]}
	}

	sort.Slice(cars, func(i, j int) bool {
		return cars[i].position > cars[j].position
	})

	var stack []float64

	for _, c := range cars {
		timeToTarget := float64(target-c.position) / float64(c.speed)

		if len(stack) == 0 || timeToTarget > stack[len(stack)-1] {
			stack = append(stack, timeToTarget)
		}
	}

	return len(stack)
}