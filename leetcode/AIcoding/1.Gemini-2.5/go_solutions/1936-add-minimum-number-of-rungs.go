func addRungs(rungs []int, dist int) int {
    addedRungs := 0
    currentHeight := 0 // Start at height 0

    for _, rung := range rungs {
        diff := rung - currentHeight
        if diff > dist {
            // Calculate how many rungs are needed.
            //