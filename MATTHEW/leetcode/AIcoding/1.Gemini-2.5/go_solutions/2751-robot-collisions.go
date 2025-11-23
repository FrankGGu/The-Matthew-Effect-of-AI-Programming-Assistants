package main

import (
	"sort"
)

type Robot struct {
	id        int // Original index to sort results
	position  int
	health    int
	direction byte
}

func robotCollisions(positions []int, healths []int, directions string) []int {
	n := len(positions)
	robots := make([]Robot, n)

	// Initialize Robot structs
	for i := 0; i < n; i++ {
		robots[i] = Robot{
			id:        i,
			position:  positions[i],
			health:    healths[i],
			direction: directions[i],
		}
	}

	// Sort robots by their positions to process collisions in order
	sort.Slice(robots, func(i, j int) bool {
		return robots[i].position < robots[j].position
	})

	// Use a stack to manage robots. Only 'R' robots or 'L' robots that have cleared all 'R' robots
	// to their left will be on the stack.
	stack := []Robot{}

	for _, currentRobot := range robots {
		if currentRobot.direction == 'R' {
			// If a robot is moving right, it is pushed onto the stack.
			stack = append(stack, currentRobot)
		} else { // currentRobot.direction == 'L'
			// If a robot is moving left, it might collide with 'R' robots on the stack.
			for len(stack) > 0 && stack[len(stack)-1].direction == 'R' {
				topRobot := &stack[len(stack)-1] // Get a pointer to the top robot on the stack for modification

				if topRobot.health == currentRobot.health {
					// Both robots have equal health, both are destroyed.
					stack = stack[:len(stack)-1] // Pop the top robot
					currentRobot.health = 0      // Mark current robot as destroyed
					break                        // Current robot is destroyed, no further collisions for it
				} else if topRobot.health > currentRobot.health {
					// The right-moving robot has higher health. It survives with reduced health.
					topRobot.health--           // Reduce health of the surviving robot on stack
					currentRobot.health = 0     // Mark current robot as destroyed
					break                       // Current robot is destroyed, no further collisions for it
				} else { // topRobot.health < currentRobot.health
					// The left-moving robot has higher health. It survives with reduced health.
					stack = stack[:len(stack)-1] // Pop the destroyed right-moving robot
					currentRobot.health--        // Reduce health of the surviving left-moving robot
					// The currentRobot (now with reduced health) continues to collide with the next robot on stack
				}
			}
			// If the currentRobot survived all collisions (health > 0)
			// and either the stack is empty or the top robot is also moving 'L' (no collision possible),
			// then add it to the stack.
			if currentRobot.health > 0 {
				stack = append(stack, currentRobot)
			}
		}
	}

	// Filter out robots with health 0 (destroyed) and prepare for final sorting
	survivors := make([]Robot, 0, len(stack))
	for _, r := range stack {
		if r.health > 0 {
			survivors = append(survivors, r)
		}
	}

	// Sort the surviving robots by their original index to match the output requirement
	sort.Slice(survivors, func(i, j int) bool {
		return survivors[i].id < survivors[j].id
	})

	// Extract healths of the surviving robots
	result := make([]int, len(survivors))
	for i, r := range survivors {
		result[i] = r.health
	}

	return result
}