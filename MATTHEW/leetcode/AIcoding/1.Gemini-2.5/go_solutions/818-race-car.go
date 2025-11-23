package main

import (
	"container/list"
)

type State struct {
	pos   int
	speed int
	steps int
}

func racecar(target int) int {
	queue := list.New()
	queue.PushBack(State{0, 1, 0}) // Initial state: pos 0, speed 1, 0 steps

	visited := make(map[struct{ pos, speed int }]bool)
	visited[struct{ pos, speed int }{0, 1}] = true

	// Define bounds for pruning.
	// For target up to 10000, a speed of 2^14 (16384) or 2^15 (32768) is typically sufficient
	// to reach or overshoot the target.
	// Positions can also go slightly negative if reversing is optimal.
	// A safe upper bound for position and speed magnitude is 2^15 = 32768.
	// This covers positions from -32768 to 32768 and speeds from -32768 to 32768.
	const maxVal = 32768

	for queue.Len() > 0 {
		e := queue.Front()
		queue.Remove(e)
		curr := e.Value.(State)

		if curr.pos == target {
			return curr.steps
		}

		// Option A: Accelerate
		nextPosA := curr.pos + curr.speed
		nextSpeedA := curr.speed * 2
		nextStepsA := curr.steps + 1
		stateA := struct{ pos, speed int }{nextPosA, nextSpeedA}

		// Pruning for A:
		// Check if the new state is within reasonable bounds and not visited.
		// If position or speed magnitude exceeds maxVal, it's likely not optimal.
		if nextPosA >= -maxVal && nextPosA <= maxVal &&
			nextSpeedA >= -maxVal && nextSpeedA <= maxVal &&
			!visited[stateA] {
			queue.PushBack(State{nextPosA, nextSpeedA, nextStepsA})
			visited[stateA] = true
		}

		// Option R: Reverse
		nextPosR := curr.pos
		nextSpeedR := 0
		if curr.speed > 0 {
			nextSpeedR = -1
		} else { // curr.speed < 0
			nextSpeedR = 1
		}
		nextStepsR := curr.steps + 1
		stateR := struct{ pos, speed int }{nextPosR, nextSpeedR}

		// Pruning for R:
		// nextPosR is curr.pos, so its bounds are already checked by the current state.
		// nextSpeedR is always 1 or -1, so it's always within bounds.
		// Only check if not visited.
		if !visited[stateR] {
			queue.PushBack(State{nextPosR, nextSpeedR, nextStepsR})
			visited[stateR] = true
		}
	}
	return -1 // Should not be reached for valid targets (target is always reachable)
}