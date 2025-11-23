func maxSatisfied(customers []int, grumpy []int, minutes int) int {
    n := len(customers)

    // Calculate initially satisfied customers (when owner is not grumpy)
    initialSatisfied := 0
    for i := 0; i < n; i++ {
        if grumpy[i] ==