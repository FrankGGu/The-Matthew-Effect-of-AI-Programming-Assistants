func getCollisionTimes(cars [][]int) []float64 {
    n := len(cars)
    ans := make([]float64, n)
    for i := 0; i < n; i++ {
        ans[i] = -1.0
    }

    stack := []int{} // Stores indices of cars, from right to left (bottom to top)

    // Iterate from right to left
    for i := n - 1; i >= 0; i-- {
        currentPos := float64(cars[i][0])
        currentSpeed := float64(cars[i][1])

        // While stack is not empty, check conditions for popping cars from stack
        for len(stack) > 0 {
            j := stack[len(stack)-1] // Index of car at stack top (car to the immediate right of current car i)

            nextCarPos := float64(cars[j][0])
            nextCarSpeed := float64(cars[j][1])

            // Condition 1: Current car is slower or same speed as the car at stack top.
            // Car 'i' will never catch car 'j'.
            // Therefore, 'j' is not a collision target for 'i'.
            // Also, any car 'k' to the left of 'i' will also not catch 'j' before 'i' does (if at all).
            // So, 'j' is irrelevant for 'i' and any car to its left. Pop 'j'.
            if currentSpeed <= nextCarSpeed {
                stack = stack[:len(stack)-1]
            } else {
                // Condition 2: Current car is faster than the car at stack top. Potential collision.

                // Calculate time for current car 'i' to collide with car 'j'.
                t_ij := (nextCarPos - currentPos) / (currentSpeed - nextCarSpeed)

                // If car 'j' never collides with a car to its right (ans[j] == -1.0)
                // OR current car 'i' collides with 'j' before or at the same time 'j' collides with its next car (t_ij <= ans[j])
                if ans[j] == -1.0 || t_ij <= ans[j] {
                    ans[i] = t_ij
                    break // Found the first collision for car 'i', break from inner loop
                } else {
                    // Current car 'i' would collide with 'j' AFTER 'j' has already collided with its next car.
                    // This means 'j' is no longer a single car but part of a fleet.
                    // Car 'i' will effectively collide with the fleet 'j' is part of.
                    // So, 'j' is not the direct collision target for 'i'. Pop 'j' and check the next car on stack.
                    stack = stack[:len(stack)-1]
                }
            }
        }
        // Push current car's index onto the stack
        stack = append(stack, i)
    }

    return ans
}